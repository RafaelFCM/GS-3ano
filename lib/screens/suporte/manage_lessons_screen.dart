import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/services/db_service.dart';

class ManageLessonsScreen extends StatefulWidget {
  @override
  _ManageLessonsScreenState createState() => _ManageLessonsScreenState();
}

class _ManageLessonsScreenState extends State<ManageLessonsScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _courseIdController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _videoUrlController = TextEditingController();
  final DBService _dbService = DBService();

  Future<void> _insertLesson() async {
    if (_courseIdController.text.isNotEmpty &&
        _titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _videoUrlController.text.isNotEmpty) {
      await _dbService.insertLesson({
        'courseId': int.parse(_courseIdController.text),
        'title': _titleController.text,
        'description': _descriptionController.text,
        'videoUrl': _videoUrlController.text,
      });
      _clearFields();
      _showAlert('Lição criada com sucesso!');
      setState(() {});
    } else {
      _showAlert('Por favor, preencha todos os campos.');
    }
  }

  Future<void> _updateLesson() async {
    if (_idController.text.isNotEmpty &&
        _courseIdController.text.isNotEmpty &&
        _titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _videoUrlController.text.isNotEmpty) {
      int lessonId = int.parse(_idController.text);
      bool lessonExists = await _dbService.lessonExists(lessonId);
      if (lessonExists) {
        await _dbService.updateLesson(lessonId, {
          'courseId': int.parse(_courseIdController.text),
          'title': _titleController.text,
          'description': _descriptionController.text,
          'videoUrl': _videoUrlController.text,
        });
        _clearFields();
        _showAlert('Lição atualizada com sucesso!');
        setState(() {});
      } else {
        _showAlert('ID da lição não encontrado.');
        _clearFields();
      }
    } else {
      _showAlert('Por favor, preencha todos os campos.');
    }
  }

  Future<void> _deleteLesson(int lessonsId) async {
    await _dbService.deleteLesson(lessonsId);
    setState(() {});
  }

  void _confirmDeleteLesson(BuildContext context, int lessonsId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação de exclusão'),
          content: Text('Tem certeza que quer excluir a lição?'),
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
                _deleteLesson(lessonsId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _populateFields(int lessonId) async {
    final lesson = await _dbService.getLessonById(lessonId);
    if (lesson != null) {
      _courseIdController.text = lesson['courseId'].toString();
      _titleController.text = lesson['title'];
      _descriptionController.text = lesson['description'];
      _videoUrlController.text = lesson['videoUrl'];
    } else {
      _clearFields();
      _showAlert('Lição não encontrada.');
    }
  }

  Future<List<Map<String, dynamic>>> _fetchLessons() async {
    return await _dbService.getLessonsSuport();
  }

  void _clearFields() {
    _idController.clear();
    _courseIdController.clear();
    _titleController.clear();
    _descriptionController.clear();
    _videoUrlController.clear();
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
      final int? lessonId = int.tryParse(_idController.text);
      if (lessonId != null) {
        _populateFields(lessonId);
      } else {
        _clearFields();
      }
    });
  }

  @override
  void dispose() {
    _idController.dispose();
    _courseIdController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _videoUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Lições'),
        backgroundColor: Colors.blueGrey[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'ID da Lição'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _courseIdController,
                decoration: InputDecoration(labelText: 'ID do Curso'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
              ),
              TextField(
                controller: _videoUrlController,
                decoration: InputDecoration(labelText: 'URL do Vídeo'),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _insertLesson,
                    child: Text('Criar Lição'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[300],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _updateLesson,
                    child: Text('Atualizar Lição'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[300],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _fetchLessons(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  final lessons = snapshot.data!;
                  return Container(
                    height: 300,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: lessons.length,
                      itemBuilder: (context, index) {
                        final lesson = lessons[index];
                        return ListTile(
                          title: Text(lesson['title']),
                          subtitle: Text(
                              'ID da Lição: ${lesson['lessonsId']} & ID do Curso: ${lesson['courseId']}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _confirmDeleteLesson(
                                  context, lesson['lessonsId']);
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
