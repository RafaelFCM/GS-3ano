import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/screens/suporte/manage_courses_screen.dart';
import 'package:pharmaconnect_project/screens/suporte/manage_lessons_screen.dart';
import 'package:pharmaconnect_project/screens/suporte/manage_topics_screen.dart';
import 'package:pharmaconnect_project/screens/suporte/manage_users_screen.dart';
import 'package:pharmaconnect_project/screens/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupportDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Painel de Suporte'),
        automaticallyImplyLeading: false, // Remove o botão de voltar
        backgroundColor: Colors.blueGrey[300],
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isAuthenticated', false);
              await prefs.remove('userId');

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: GridView.count(
          padding: const EdgeInsets.all(16.0),
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildDashboardButton(
              context,
              icon: Icons.person,
              label: 'Gerenciar Usuários',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageUsersScreen()),
                );
              },
            ),
            _buildDashboardButton(
              context,
              icon: Icons.book,
              label: 'Gerenciar Cursos',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ManageCoursesScreen()),
                );
              },
            ),
            _buildDashboardButton(
              context,
              icon: Icons.video_library,
              label: 'Gerenciar Lições',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ManageLessonsScreen()),
                );
              },
            ),
            _buildDashboardButton(
              context,
              icon: Icons.topic,
              label: 'Gerenciar Tópicos',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageTopicsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[300],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
