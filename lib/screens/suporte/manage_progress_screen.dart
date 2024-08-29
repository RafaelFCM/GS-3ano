// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/screens/suporte/users_progress_screen.dart';
import 'package:pharmaconnect_project/services/db_service.dart';
import 'package:pharmaconnect_project/screens/certificate_screen/certificate_screen.dart';

class ManageProgressScreen extends StatefulWidget {
  @override
  _ManageProgressScreenState createState() => _ManageProgressScreenState();
}

class _ManageProgressScreenState extends State<ManageProgressScreen> {
  List<Map<String, dynamic>> allUsers = [];
  List<Map<String, dynamic>> filteredUsers = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _searchController.addListener(_filterUsers);
  }

  Future<void> _loadUsers() async {
    final dbService = DBService();
    allUsers = await dbService.getAllUsersWithCourses();
    setState(() {
      filteredUsers = allUsers;
    });
  }

  void _filterUsers() {
    String searchQuery = _searchController.text.toLowerCase();
    setState(() {
      filteredUsers = allUsers.where((user) {
        return matchesSearchQuery(user['name'], searchQuery);
      }).toList();
    });
  }

  bool matchesSearchQuery(String? userName, String searchQuery) {
    if (userName == null) {
      return false;
    }
    return userName.toLowerCase().contains(searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Progresso dos Usuários'),
        backgroundColor: Colors.blueGrey[300],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar por usuário',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                var user = filteredUsers[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    title: Text(
                      user['name'] ?? 'Nome não disponível',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[700],
                      ),
                    ),
                    subtitle: Text(
                      'Email: ${user['email'] ?? 'Email não disponível'}',
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blueGrey[300],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UsersProgressScreen(user: user),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
