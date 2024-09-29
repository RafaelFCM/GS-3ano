import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/screens/chatbot_screen/chatbot_screen.dart';
import 'package:pharmaconnect_project/screens/course_detail_screen/course_detail_screen.dart';
import 'package:pharmaconnect_project/screens/login_screen/login_screen.dart';
import 'package:pharmaconnect_project/screens/personality_test_screen/personality_test_screen.dart';
import 'package:pharmaconnect_project/screens/ranking_screen/ranking.dart';
import 'package:pharmaconnect_project/screens/ticket_screen/ticket_screen.dart';
import 'package:pharmaconnect_project/screens/settings_screen/settings_screen.dart';
import 'package:pharmaconnect_project/screens/compliance_screen/compliance_screen.dart';
import 'package:pharmaconnect_project/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:pharmaconnect_project/screens/profile_screen/profile_screen.dart';
import 'package:pharmaconnect_project/screens/search_screen/search_screen.dart';
import 'package:pharmaconnect_project/screens/topic_listing_screen/topic_listing_screen.dart';
import 'package:pharmaconnect_project/screens/notification_screen/notification_screen.dart';
import 'package:pharmaconnect_project/screens/survey_screen/survey_screen.dart';
import 'package:pharmaconnect_project/services/db_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pharmaconnect_project/screens/onboarding/onboarding_routes_screen.dart';

class DashboardScreen extends StatefulWidget {
  final int userId;
  final int initialTabIndex; // Aba de onboarding;

  DashboardScreen({required this.userId, this.initialTabIndex = 0});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late int _selectedIndex;
  List<Map<String, dynamic>> ongoingCourses = [];
  List<Map<String, dynamic>> finalizedCourses = [];
  List<Map<String, dynamic>> favoriteCourses = [];

  @override
  void initState() {
    super.initState();
    _selectedIndex =
        widget.initialTabIndex; // Aba inicial baseada no parâmetro recebido
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    final dbService = DBService();
    ongoingCourses = await dbService.getOngoingCourses(widget.userId);
    finalizedCourses = await dbService.getFinalizedCourses(widget.userId);
    favoriteCourses = await dbService.getFavoriteCourses(widget.userId);

    setState(() {});
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
      _buildDashboardContent(), // Home
      ProfileScreen(userId: widget.userId), // Perfil
      ChatbotScreen(userId: widget.userId), // Suporte
      TopicListingScreen(
          userId: widget.userId, onEnroll: _loadCourses), // Cursos
      OnboardingRoutesScreen(userId: widget.userId), // Onboarding
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[300],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => _showMenu(context),
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
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NotificationScreen(userId: widget.userId)),
              );
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
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
            icon: Icon(Icons.support_agent),
            label: 'Suporte',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Cursos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Onboarding',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueGrey[300],
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildDashboardContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Em Andamento'),
          _buildCourseList(ongoingCourses, showProgress: true),
          SizedBox(height: 20),
          _buildSectionTitle('Concluídos'),
          _buildCourseList(finalizedCourses),
          SizedBox(height: 20),
          _buildSectionTitle('Favoritos'),
          _buildCourseList(favoriteCourses),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey[700],
      ),
    );
  }

  Widget _buildCourseList(List<Map<String, dynamic>> courses,
      {bool showProgress = false}) {
    if (courses.isEmpty) {
      return Center(child: Text('Nenhum curso encontrado.'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        var course = courses[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10),
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
                    userId: widget.userId,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              _buildMenuItem(context, Icons.person, 'Editar Perfil',
                  EditProfileScreen(userId: widget.userId)),
              _buildMenuItem(
                  context, Icons.settings, 'Ajustes', SettingsScreen()),
              _buildMenuItem(
                  context, Icons.message, 'Abertura de ticket', TicketScreen()),
              _buildMenuItem(
                  context, Icons.help, 'Compliance', ComplianceScreen()),
              _buildMenuItem(
                  context,
                  Icons.quiz,
                  'Teste de Personalidade',
                  PersonalityTestScreen(
                    userId: widget.userId,
                    onComplete: () {
                      setState(() {
                        // Atualiza a interface após o teste de personalidade
                      });
                    },
                  )),
              _buildMenuItem(context, Icons.edit_note, 'Pesquisa satisfação',
                  SurveyScreen()),
              _buildMenuItem(context, Icons.bar_chart_outlined,
                  'Ranking de Usuários', RankingScreen()),
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
  }

  ListTile _buildMenuItem(
      BuildContext context, IconData icon, String title, Widget screen) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }
}
