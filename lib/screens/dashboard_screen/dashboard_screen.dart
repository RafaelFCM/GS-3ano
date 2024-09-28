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

// MEXIDO

class DashboardScreen extends StatefulWidget {
  final int userId;

  DashboardScreen({required this.userId});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> ongoingCourses = [];
  List<Map<String, dynamic>> finalizedCourses = [];
  List<Map<String, dynamic>> favoriteCourses = [];

  @override
  void initState() {
    super.initState();
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














// ORIGINAL




// class DashboardScreen extends StatefulWidget {
//   final int userId;

//   DashboardScreen({required this.userId});

//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int _selectedIndex = 0;
//   bool _hasCompletedTest = false;
//   List<Map<String, dynamic>> ongoingCourses = [];
//   List<Map<String, dynamic>> finalizedCourses = [];
//   List<Map<String, dynamic>> favoriteCourses = [];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _loadCourses();

//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       _hasCompletedTest = await _checkPersonalityTestCompletion(widget.userId);
//       if (!_hasCompletedTest) {
//         _showPersonalityTestAlert();
//       }
//     });
//   }

//   Future<void> _loadCourses() async {
//     final dbService = DBService();
//     ongoingCourses = await dbService.getOngoingCourses(widget.userId);
//     finalizedCourses = await dbService.getFinalizedCourses(widget.userId);
//     favoriteCourses = await dbService.getFavoriteCourses(widget.userId);

//     setState(() {});
//   }

//   Future<bool> _checkPersonalityTestCompletion(int userId) async {
//     final dbService = DBService();
//     final profile = await dbService.getProfile(userId);
//     return profile != null && profile['personalityType'] != 'Tipo Padrão';
//   }

//   Future<void> _clearConversation(int userId) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('conversation_$userId');
//   }

//   void _showPersonalityTestAlert() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Teste de Personalidade"),
//           content: Text(
//               "Você ainda não completou o teste de personalidade. Gostaria de fazê-lo agora?"),
//           actions: <Widget>[
//             TextButton(
//               child: Text("Agora"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => PersonalityTestScreen(
//                             userId: widget.userId,
//                             onComplete: () {
//                               setState(() {
//                                 _hasCompletedTest = true;
//                               });
//                             },
//                           )),
//                 );
//               },
//             ),
//             TextButton(
//               child: Text("Depois"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   void _logout() async {
//     final prefs = await SharedPreferences.getInstance();

//     // Limpar o histórico de conversa do usuário
//     await _clearConversation(widget.userId);

//     // Remover autenticação e ID do usuário
//     await prefs.setBool('isAuthenticated', false);
//     await prefs.remove('userId');

//     // Navegar para a tela de login
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => LoginScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> _pages = [
//       DashboardContent(
//         ongoingCourses: ongoingCourses,
//         finalizedCourses: finalizedCourses,
//         favoriteCourses: favoriteCourses,
//         tabController: _tabController,
//         userId: widget.userId,
//       ),
//       ProfileScreen(userId: widget.userId),
//       // NotificationScreen(userId: widget.userId),
//       ChatbotScreen(userId: widget.userId),
//       TopicListingScreen(onEnroll: _loadCourses, userId: widget.userId),
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueGrey[300],
//         leading: IconButton(
//           icon: Icon(Icons.menu),
//           onPressed: () {
//             showModalBottomSheet(
//               context: context,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//               ),
//               builder: (BuildContext context) {
//                 return Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20),
//                       bottomLeft: Radius.circular(20),
//                       bottomRight: Radius.circular(20),
//                     ),
//                   ),
//                   child: ListView(
//                     padding: EdgeInsets.zero,
//                     children: <Widget>[
//                       ListTile(
//                         leading: Icon(Icons.person),
//                         title: Text('Editar Perfil'),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   EditProfileScreen(userId: widget.userId),
//                             ),
//                           );
//                         },
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.settings),
//                         title: Text('Ajustes'),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => SettingsScreen()),
//                           );
//                         },
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.message),
//                         title: Text('Abertura de ticket'),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => TicketScreen()),
//                           );
//                         },
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.help),
//                         title: Text('Compliance'),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => ComplianceScreen()),
//                           );
//                         },
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.quiz),
//                         title: Text('Teste de Personalidade'),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => PersonalityTestScreen(
//                                       userId: widget.userId,
//                                       onComplete: () {
//                                         setState(() {
//                                           _hasCompletedTest = true;
//                                         });
//                                       },
//                                     )),
//                           );
//                         },
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.edit_note),
//                         title: Text('Pesquisa satisfação'),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => SurveyScreen()),
//                           );
//                         },
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.bar_chart_outlined),
//                         title: Text('Ranking de Usuários'),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => RankingScreen()),
//                           );
//                         },
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.logout),
//                         title: Text('Sair do Usuário'),
//                         onTap: _logout,
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => SearchScreen(userId: widget.userId)),
//               );
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.notifications),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         NotificationScreen(userId: widget.userId)),
//               );
//             },
//           ),
//         ],
//       ),
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: _pages,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Perfil',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.support_agent),
//             label: 'Suporte',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.book),
//             label: 'Cursos',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blueGrey[300],
//         unselectedItemColor: Colors.black,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// class DashboardContent extends StatelessWidget {
//   final List<Map<String, dynamic>> ongoingCourses;
//   final List<Map<String, dynamic>> finalizedCourses;
//   final List<Map<String, dynamic>> favoriteCourses;
//   final TabController tabController;
//   final int userId;

//   DashboardContent({
//     required this.ongoingCourses,
//     required this.finalizedCourses,
//     required this.favoriteCourses,
//     required this.tabController,
//     required this.userId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TabBar(
//           controller: tabController,
//           labelColor: Colors.blueGrey[300],
//           unselectedLabelColor: Colors.black,
//           tabs: [
//             Tab(text: 'Em andamento'),
//             Tab(text: 'Finalizados'),
//             Tab(text: 'Favoritos'),
//           ],
//         ),
//         Expanded(
//           child: TabBarView(
//             controller: tabController,
//             children: [
//               _buildCourseList(ongoingCourses, true),
//               _buildCourseList(finalizedCourses, false),
//               _buildCourseList(favoriteCourses, false),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCourseList(
//       List<Map<String, dynamic>> courses, bool showProgress) {
//     if (courses.isEmpty) {
//       return Center(child: Text('Nenhum curso encontrado.'));
//     }

//     return ListView.builder(
//       itemCount: courses.length,
//       itemBuilder: (context, index) {
//         var course = courses[index];
//         return Card(
//           margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//           child: ListTile(
//             title: Text(
//               course['title'] ?? '',
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.blueGrey[700]),
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(course['description'] ?? ''),
//                 if (showProgress) SizedBox(height: 5),
//                 if (showProgress)
//                   LinearProgressIndicator(
//                     value: course['progress'] ?? 0.0,
//                     backgroundColor: Colors.grey[300],
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
//                   ),
//               ],
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => CourseDetailScreen(
//                     courseId: course['courseId'],
//                     userId: userId,
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
