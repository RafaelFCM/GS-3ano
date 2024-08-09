import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/services/db_service.dart';

class ManageCoursesScreen extends StatefulWidget {
  @override
  _ManageCoursesScreenState createState() => _ManageCoursesScreenState();
}

class _ManageCoursesScreenState extends State<ManageCoursesScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _instructorsController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _topicIdController = TextEditingController();
  final DBService _dbService = DBService();

  Future<void> _insertCourse() async {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _imageUrlController.text.isNotEmpty &&
        _instructorsController.text.isNotEmpty &&
        _durationController.text.isNotEmpty &&
        _topicIdController.text.isNotEmpty) {
      int topicId = int.parse(_topicIdController.text);
      bool topicExists = await _dbService.topicExists(topicId);
      if (topicExists) {
        await _dbService.insertCourse({
          'title': _titleController.text,
          'description': _descriptionController.text,
          'imageUrl': _imageUrlController.text,
          'instructors': _instructorsController.text,
          'duration': _durationController.text,
          'topicId': topicId,
        });
        _clearFields();
        _showAlert('Curso criado com sucesso!');
        setState(() {});
      } else {
        _showAlert('ID do Tópico não existe.');
      }
    } else {
      _showAlert('Por favor, preencha todos os campos.');
    }
  }

  Future<void> _updateCourse() async {
    if (_idController.text.isNotEmpty &&
        _titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _imageUrlController.text.isNotEmpty &&
        _instructorsController.text.isNotEmpty &&
        _durationController.text.isNotEmpty &&
        _topicIdController.text.isNotEmpty) {
      int courseId = int.parse(_idController.text);
      int topicId = int.parse(_topicIdController.text);
      bool topicExists = await _dbService.topicExists(topicId);
      if (topicExists) {
        await _dbService.updateCourse(courseId, {
          'title': _titleController.text,
          'description': _descriptionController.text,
          'imageUrl': _imageUrlController.text,
          'instructors': _instructorsController.text,
          'duration': _durationController.text,
          'topicId': topicId,
        });
        _clearFields();
        _showAlert('Curso atualizado com sucesso!');
        setState(() {});
      } else {
        _showAlert('ID do Tópico não existe.');
      }
    } else {
      _showAlert('Por favor, preencha todos os campos.');
    }
  }

  Future<void> _deleteCourse(int courseId) async {
    await _dbService.deleteCourse(courseId);
    setState(() {});
  }

  void _confirmDeleteCourse(BuildContext context, int courseId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação de exclusão'),
          content: Text('Tem certeza que quer excluir o curso?'),
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
                _deleteCourse(courseId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _fetchCourseDetails() async {
    if (_idController.text.isNotEmpty) {
      int courseId = int.parse(_idController.text);
      final course = await _dbService.getCourseById(courseId);

      if (course != null) {
        _titleController.text = course['title'];
        _descriptionController.text = course['description'];
        _imageUrlController.text = course['imageUrl'];
        _instructorsController.text = course['instructors'];
        _durationController.text = course['duration'];
        _topicIdController.text = course['topicId'].toString();
      } else {
        _showAlert('Curso não encontrado.');
        _clearFields();
      }
    }
  }

  Future<List<Map<String, dynamic>>> _fetchCourses() async {
    return await _dbService.getCourses();
  }

  void _clearFields() {
    _idController.clear();
    _titleController.clear();
    _descriptionController.clear();
    _imageUrlController.clear();
    _instructorsController.clear();
    _durationController.clear();
    _topicIdController.clear();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Cursos'),
        backgroundColor: Colors.blueGrey[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'ID do Curso'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _fetchCourseDetails();
                  }
                },
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
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'URL da Imagem'),
              ),
              TextField(
                controller: _instructorsController,
                decoration: InputDecoration(labelText: 'Instrutores'),
              ),
              TextField(
                controller: _durationController,
                decoration: InputDecoration(labelText: 'Duração'),
              ),
              TextField(
                controller: _topicIdController,
                decoration: InputDecoration(labelText: 'ID do Tópico'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _insertCourse,
                    child: Text('Criar Curso'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[300],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _updateCourse,
                    child: Text('Atualizar Curso'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[300],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _fetchCourses(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  final courses = snapshot.data!;
                  return Container(
                    height: 200,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final course = courses[index];
                        return ListTile(
                          title: Text(course['title']),
                          subtitle: Text(
                              'ID do Curso: ${course['courseId']} & ID do Tópico: ${course['topicId']}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _confirmDeleteCourse(context, course['courseId']);
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
