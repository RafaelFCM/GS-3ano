import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/services/db_service.dart';

class RankingScreen extends StatefulWidget {
  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  late Future<List<Map<String, dynamic>>> _rankingFuture;

  @override
  void initState() {
    super.initState();
    _rankingFuture = DBService().getUserRanking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ranking de Usuários'),
        backgroundColor: Colors.blueGrey[300],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _rankingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar o ranking'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum usuário encontrado'));
          }

          final users = snapshot.data!;

          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final name = user['name'] ??
                  'Nome não disponível'; // Agora buscando da tabela profiles
              final points =
                  user['points']?.toString() ?? '0'; // Pontos da tabela users

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                    backgroundColor: Colors.blueGrey[300],
                  ),
                  title: Text(name),
                  trailing: Text('$points pontos'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
