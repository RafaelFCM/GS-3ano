import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/services/db_service.dart';
import 'package:pharmaconnect_project/screens/course_screen/course_screen.dart';

class CourseDetailScreen extends StatefulWidget {
  final int courseId;
  final int userId;

  CourseDetailScreen({required this.courseId, required this.userId});

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  late Future<Map<String, dynamic>?> _courseDetails;
  late Future<List<Map<String, dynamic>>> _lessons;
  String? _courseStatus;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _courseDetails = DBService().getCourse(widget.courseId);
    _lessons = DBService().getLessons(widget.courseId);
    _checkCourseStatus();
  }

  Future<void> _checkCourseStatus() async {
    final status =
        await DBService().getCourseStatus(widget.userId, widget.courseId);
    setState(() {
      _courseStatus = status;
      _isFavorite = status == 'favorite';
    });
  }

  Future<void> _toggleFavorite() async {
    if (_isFavorite) {
      await DBService().updateUserCourseStatus(
          widget.userId, widget.courseId, 'not started');
    } else {
      await DBService()
          .insertUserCourse(widget.userId, widget.courseId, 0.0, 'favorite');
    }
    _checkCourseStatus();
  }

  Future<void> _toggleCourseStatus() async {
    if (_courseStatus == 'ongoing') {
      await DBService().updateUserCourseStatus(
          widget.userId, widget.courseId, 'not started');
    } else {
      await DBService()
          .updateUserCourseStatus(widget.userId, widget.courseId, 'ongoing');
    }
    _checkCourseStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Curso'),
        backgroundColor: Colors.blueGrey[300],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _courseDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Center(child: Text('Erro ao carregar detalhes do curso'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            print('No data');
            return Center(child: Text('Curso não encontrado'));
          }

          final course = snapshot.data!;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    course['imageUrl'] ??
                        'assets/images/default_course_image.jpg',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  course['title'] ?? 'Título não disponível',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[700]),
                ),
                SizedBox(height: 10),
                Text(
                  course['description'] ?? 'Descrição não disponível',
                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                ),
                SizedBox(height: 10),
                Text(
                  'Instrutores: ${course['instructors'] ?? 'Instrutores não disponíveis'}',
                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                ),
                SizedBox(height: 10),
                Text(
                  'Duração: ${course['duration'] ?? 'Duração não disponível'}',
                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _toggleFavorite,
                      child: Text(
                          _isFavorite ? 'Remover dos Favoritos' : 'Favoritar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isFavorite ? Colors.grey : Colors.blue,
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _toggleCourseStatus,
                      child: Text(_courseStatus == 'ongoing'
                          ? 'Parar Curso'
                          : 'Iniciar Curso'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _courseStatus == 'ongoing'
                            ? Colors.grey
                            : Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Lições',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[700]),
                ),
                SizedBox(height: 10),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: _lessons,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      print('Error: ${snapshot.error}');
                      return Center(child: Text('Erro ao carregar lições'));
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      print('No lessons data');
                      return Center(child: Text('Nenhuma lição encontrada'));
                    }

                    final lessons = snapshot.data!;

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: lessons.length,
                      itemBuilder: (context, index) {
                        final lesson = lessons[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          elevation: 5,
                          child: ListTile(
                            contentPadding: EdgeInsets.all(10),
                            title: Text(
                              lesson['title'] ?? 'Título não disponível',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[700]),
                            ),
                            subtitle: Text(
                              lesson['description'] ??
                                  'Descrição não disponível',
                              style: TextStyle(color: Colors.grey[800]),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CourseScreen(
                                    courseId: widget.courseId,
                                    userId: widget.userId,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
