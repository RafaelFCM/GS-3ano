import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/screens/login_screen/login_screen.dart';
import 'package:pharmaconnect_project/screens/profile_screen/profile_screen.dart';

class NotificationScreen extends StatelessWidget {
  final int userId;

  NotificationScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(userId: userId),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.support),
              title: Text('Suporte'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('FAQ'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair do Usuário'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          NotificationTile(
            type: "ARTIGO",
            title: "Discord: o que é e como participar da comunidade da Alura?",
            time: "2 horas atrás",
          ),
          NotificationTile(
            type: "PODCAST",
            title: "FIAPCAST 12: A hora e a vez de estudar IA",
            time: "2 horas atrás",
          ),
          NotificationTile(
            type: "CURSO",
            title: "Unity: criando um jogo metroidvania 2D",
            time: "3 horas atrás",
          ),
          NotificationTile(
            type: "PODCAST",
            title:
                "Engenheiro de Front-end Sênior em Lisboa, Portugal - Dev Sem Fronteiras #145",
            time: "14 horas atrás",
          ),
          NotificationTile(
            type: "PODCAST",
            title:
                "Gestão corporativa, tecnologia e cultura com Felipe Calixto da Sankhya",
            time: "14 horas atrás",
          ),
          NotificationTile(
            type: "VÍDEO",
            title:
                "Como conseguir a cidadania no exterior: um guia para devs | Hipsters: Carreira no Exterior",
            time: "20 horas atrás",
          ),
          NotificationTile(
            type: "ARTIGO",
            title:
                "Ingestão de dados em tempo real no Data Lake com AWS Kinesis",
            time: "1 dia atrás",
          ),
        ],
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String type;
  final String title;
  final String time;

  NotificationTile({
    required this.type,
    required this.title,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        title: Text(
          type,
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(title),
        trailing: Text(time),
      ),
    );
  }
}
