import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/screens/course_feedback_screen/course_feedback_screen.dart';
import 'package:pharmaconnect_project/screens/course_screen/course_screen.dart';

class TestScreen extends StatefulWidget {
  final int courseId;
  final int userId;
  final Function onComplete;

  TestScreen(
      {required this.courseId, required this.userId, required this.onComplete});

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final List<Map<String, dynamic>> questions = List.generate(
    15,
    (index) => {
      'question': 'Questão ${index + 1}',
      'alternatives': [
        'Resposta A',
        'Resposta B',
        'Resposta C',
        'Resposta D',
        'Resposta E',
      ],
      'correctAnswer': 'Resposta A',
      'selectedAnswer': '',
    },
  );

  void _submitAnswers() async {
    if (questions.any((q) => q['selectedAnswer'] == '')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, responda todas as questões.')),
      );
      return;
    }

    int correctAnswers = questions
        .where((q) => q['selectedAnswer'] == q['correctAnswer'])
        .length;

    if (correctAnswers >= 12) {
      await widget.onComplete();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            passed: true,
            correctAnswers: correctAnswers,
            courseId: widget.courseId,
            userId: widget.userId,
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            passed: false,
            correctAnswers: correctAnswers,
            courseId: widget.courseId,
            userId: widget.userId,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avaliação'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Instruções: Você deve acertar pelo menos 12 de 15 questões para passar.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                var question = questions[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question['question'],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        ...question['alternatives'].map<Widget>((alternative) {
                          return RadioListTile(
                            title: Text(alternative),
                            value: alternative,
                            groupValue: question['selectedAnswer'],
                            onChanged: (value) {
                              setState(() {
                                question['selectedAnswer'] = value;
                              });
                            },
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitAnswers,
                child: Text('Enviar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final bool passed;
  final int correctAnswers;
  final int courseId;
  final int userId;

  ResultScreen(
      {required this.passed,
      required this.correctAnswers,
      required this.courseId,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => passed
                    ? FeedbackScreen(courseId: courseId, userId: userId)
                    : CourseScreen(courseId: courseId, userId: userId),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              passed
                  ? 'Parabéns! Você passou!'
                  : 'Não passou. Tente novamente.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Você acertou $correctAnswers de 15 questões.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            if (passed)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FeedbackScreen(courseId: courseId, userId: userId),
                    ),
                  );
                },
                child: Text('Avaliar Curso'),
              ),
            if (!passed)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CourseScreen(courseId: courseId, userId: userId),
                    ),
                  );
                },
                child: Text('Tentar Novamente'),
              ),
          ],
        ),
      ),
    );
  }
}
