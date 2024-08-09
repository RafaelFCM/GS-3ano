import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/screens/course_detail_screen/course_detail_screen.dart';
import 'package:pharmaconnect_project/screens/login_screen/login_screen.dart';
import 'package:pharmaconnect_project/screens/personality_test_screen/personality_test_screen.dart';
import 'package:pharmaconnect_project/screens/support_screen/support_screen.dart';
import 'package:pharmaconnect_project/screens/settings_screen/settings_screen.dart';
import 'package:pharmaconnect_project/screens/faq_screen/faq_screen.dart';
import 'package:pharmaconnect_project/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:pharmaconnect_project/screens/profile_screen/profile_screen.dart';
import 'package:pharmaconnect_project/screens/search_screen/search_screen.dart';
import 'package:pharmaconnect_project/screens/topic_listing_screen/topic_listing_screen.dart';
import 'package:pharmaconnect_project/screens/notification_screen/notification_screen.dart';
import 'package:pharmaconnect_project/services/db_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  final int userId;

  DashboardScreen({required this.userId});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  bool _hasCompletedTest = false;
  List<Map<String, dynamic>> ongoingCourses = [];
  List<Map<String, dynamic>> finalizedCourses = [];
  List<Map<String, dynamic>> favoriteCourses = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadCourses();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _hasCompletedTest = await _checkPersonalityTestCompletion(widget.userId);
      if (!_hasCompletedTest) {
        _showPersonalityTestAlert();
      }
    });
  }

  Future<void> _loadCourses() async {
    final dbService = DBService();
    ongoingCourses = await dbService.getOngoingCourses(widget.userId);
    finalizedCourses = await dbService.getFinalizedCourses(widget.userId);
    favoriteCourses = await dbService.getFavoriteCourses(widget.userId);

    setState(() {});
  }

  Future<bool> _checkPersonalityTestCompletion(int userId) async {
    final dbService = DBService();
    final profile = await dbService.getProfile(userId);
    return profile != null && profile['personalityType'] != 'Tipo Padrão';
  }

  void _showPersonalityTestAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Teste de Personalidade"),
          content: Text(
              "Você ainda não completou o teste de personalidade. Gostaria de fazê-lo agora?"),
          actions: <Widget>[
            TextButton(
              child: Text("Agora"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PersonalityTestScreen(
                            userId: widget.userId,
                            onComplete: () {
                              setState(() {
                                _hasCompletedTest = true;
                              });
                            },
                          )),
                );
              },
            ),
            TextButton(
              child: Text("Depois"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', false);
    await prefs.remove('userId');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      DashboardContent(
        ongoingCourses: ongoingCourses,
        finalizedCourses: finalizedCourses,
        favoriteCourses: favoriteCourses,
        tabController: _tabController,
        userId: widget.userId,
      ),
      ProfileScreen(userId: widget.userId),
      NotificationScreen(userId: widget.userId),
      TopicListingScreen(onEnroll: _loadCourses, userId: widget.userId),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[300],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Editar Perfil'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditProfileScreen(userId: widget.userId),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Ajustes'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsScreen()),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.support),
                        title: Text('Suporte'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SupportScreen()),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.help),
                        title: Text('FAQ'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FAQScreen()),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.assessment),
                        title: Text('Teste de Personalidade'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PersonalityTestScreen(
                                      userId: widget.userId,
                                      onComplete: () {
                                        setState(() {
                                          _hasCompletedTest = true;
                                        });
                                      },
                                    )),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('Sair do Usuário'),
                        onTap: _logout,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchScreen(userId: widget.userId)),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Cursos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueGrey[300],
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  final List<Map<String, dynamic>> ongoingCourses;
  final List<Map<String, dynamic>> finalizedCourses;
  final List<Map<String, dynamic>> favoriteCourses;
  final TabController tabController;
  final int userId;

  DashboardContent({
    required this.ongoingCourses,
    required this.finalizedCourses,
    required this.favoriteCourses,
    required this.tabController,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: tabController,
          labelColor: Colors.blueGrey[300],
          unselectedLabelColor: Colors.black,
          tabs: [
            Tab(text: 'Em andamento'),
            Tab(text: 'Finalizados'),
            Tab(text: 'Favoritos'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              _buildCourseList(ongoingCourses, true),
              _buildCourseList(finalizedCourses, false),
              _buildCourseList(favoriteCourses, false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCourseList(
      List<Map<String, dynamic>> courses, bool showProgress) {
    if (courses.isEmpty) {
      return Center(child: Text('Nenhum curso encontrado.'));
    }

    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        var course = courses[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ListTile(
            title: Text(
              course['title'] ?? '',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blueGrey[700]),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course['description'] ?? ''),
                if (showProgress) SizedBox(height: 5),
                if (showProgress)
                  LinearProgressIndicator(
                    value: course['progress'] ?? 0.0,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                  ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailScreen(
                    courseId: course['courseId'],
                    userId: userId,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
