import 'package:flutter/material.dart';

class UsersProgressScreen extends StatelessWidget {
  final Map<String, dynamic> user;

  UsersProgressScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
        backgroundColor: Colors.blueGrey[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user['name'] ?? 'Nome não disponível',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[700],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Email: ${user['email'] ?? 'Email não disponível'}',
              style: TextStyle(color: Colors.grey[800]),
            ),
            SizedBox(height: 20),
            Text(
              'Cursos Finalizados:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[700],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: user['courses'].length,
                itemBuilder: (context, index) {
                  var course = user['courses'][index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(
                        course['title'] ?? 'Título não disponível',
                        style: TextStyle(
                          color: Colors.blueGrey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Status: ${course['status'] ?? 'Status não disponível'}\nProgresso: ${course['progress'] ?? 0}%',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      onTap: () {
                        // Lógica para exibir detalhes ou certificados do curso
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
