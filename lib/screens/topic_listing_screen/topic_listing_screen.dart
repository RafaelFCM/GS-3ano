import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/screens/course_list_screen/course_list_screen.dart';
import 'package:pharmaconnect_project/services/db_service.dart';

class TopicListingScreen extends StatelessWidget {
  final VoidCallback onEnroll;
  final int userId;

  TopicListingScreen({required this.onEnroll, required this.userId});

  Future<Map<String, List<Map<String, String>>>> _getCoursesByTopic() async {
    final courses = await DBService().getCourses();
    final topics = await DBService().getTopics();
    final Map<int, String> topicNames = {
      for (var topic in topics) topic['topicId']: topic['name']
    };
    final Map<String, List<Map<String, String>>> coursesByTopic = {};

    for (var course in courses) {
      final topicName = topicNames[course['topicId']];
      if (coursesByTopic[topicName!] == null) {
        coursesByTopic[topicName] = [];
      }
      coursesByTopic[topicName]!.add({
        'id': course['courseId'].toString(),
        'title': course['title'],
        'description': course['description'],
      });
    }

    return coursesByTopic;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, List<Map<String, String>>>>(
        future: _getCoursesByTopic(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text('Erro ao carregar tópicos'));
          }

          final coursesByTopic = snapshot.data!;

          return ListView(
            children: coursesByTopic.keys.map((topic) {
              return ListTile(
                title: Text(topic),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseListScreen(
                        themeTitle: topic,
                        courses: coursesByTopic[topic]!,
                        onEnroll: (title, description) {
                          onEnroll();
                        },
                        userId: userId,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
