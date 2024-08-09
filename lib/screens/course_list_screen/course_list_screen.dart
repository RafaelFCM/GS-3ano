// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/screens/course_detail_screen/course_detail_screen.dart';
import 'package:pharmaconnect_project/services/db_service.dart';

class CourseListScreen extends StatelessWidget {
  final String themeTitle;
  final List<Map<String, String>> courses;
  final void Function(String, String) onEnroll;
  final int userId;

  CourseListScreen({
    required this.themeTitle,
    required this.courses,
    required this.onEnroll,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(themeTitle),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          var course = courses[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: ListTile(
              title: Text(course['title']!),
              subtitle: Text(course['description']!),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseDetailScreen(
                      courseId: int.parse(course['id']!),
                      userId: userId,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
