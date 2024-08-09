import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/services/db_service.dart';

class ManageTopicsScreen extends StatefulWidget {
  @override
  _ManageTopicsScreenState createState() => _ManageTopicsScreenState();
}

class _ManageTopicsScreenState extends State<ManageTopicsScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final DBService _dbService = DBService();

  Future<void> _insertTopic() async {
    if (_nameController.text.isNotEmpty) {
      await _dbService.insertTopic({'name': _nameController.text});
      _clearFields();
      _showAlert('Tópico criado com sucesso!');
      setState(() {}); // Atualiza a UI
    } else {
      _showAlert('Por favor, preencha o nome do tópico.');
    }
  }

  Future<void> _updateTopic() async {
    if (_idController.text.isNotEmpty && _nameController.text.isNotEmpty) {
      int topicId = int.parse(_idController.text);
      bool exists = await _dbService.topicExists(topicId);

      if (exists) {
        await _dbService.updateTopic(topicId, {'name': _nameController.text});
        _clearFields();
        _showAlert('Tópico atualizado com sucesso!');
        setState(() {}); // Atualiza a UI
      } else {
        _showAlert('ID do tópico não existe.');
        _clearFields();
      }
    } else {
      _showAlert('Por favor, preencha todos os campos.');
    }
  }

  Future<void> _deleteTopic(int topicId) async {
    await _dbService.deleteTopic(topicId);
    setState(() {});
  }

  void _confirmDeleteTopic(BuildContext context, int topicId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação de exclusão'),
          content: Text('Tem certeza que quer excluir o tópico?'),
          actions: <Widget>[
            TextButton(
              child: Text('Não'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Sim'),
              onPressed: () {
                _deleteTopic(topicId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> _fetchTopics() async {
    return await _dbService.getTopics();
  }

  Future<void> _fetchTopicById(int topicId) async {
    final topic = await _dbService.getTopicById(topicId);

    if (topic != null) {
      _nameController.text = topic['name'];
    } else {
      _showAlert('ID do tópico não existe.');
      _clearFields();
    }
  }

  void _clearFields() {
    _idController.clear();
    _nameController.clear();
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
        );
      },
    ).then((_) {
      setState(() {}); // Atualiza a UI quando o AlertDialog for fechado
    });
  }

  @override
  void initState() {
    super.initState();
    _idController.addListener(() {
      final int? topicId = int.tryParse(_idController.text);
      if (topicId != null) {
        _fetchTopicById(topicId);
      } else {
        _clearFields();
      }
    });
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Tópicos'),
        backgroundColor: Colors.blueGrey[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'ID do Tópico'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _insertTopic,
                    child: Text('Criar Tópico'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[300],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _updateTopic,
                    child: Text('Atualizar Tópico'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[300],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _fetchTopics(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  final topics = snapshot.data!;
                  return Container(
                    height: 450,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: topics.length,
                      itemBuilder: (context, index) {
                        final topic = topics[index];
                        return ListTile(
                          title: Text(topic['name']),
                          subtitle: Text('ID: ${topic['topicId']}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _confirmDeleteTopic(context, topic['topicId']);
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
