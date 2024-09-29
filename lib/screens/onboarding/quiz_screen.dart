// quiz_screen.dart
import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/models/module_model.dart';
import 'package:pharmaconnect_project/models/question_model.dart';
import 'package:pharmaconnect_project/screens/onboarding/onboarding_certificate_screen.dart';
import 'package:pharmaconnect_project/screens/dashboard_screen/dashboard_screen.dart';
import 'package:pharmaconnect_project/services/db_service.dart'; // Importe a tela do Dashboard

class QuizScreen extends StatefulWidget {
  final List<Question> questions;
  final List<Module> modules;
  final int currentModuleIndex;
  final int userId; // Adicione o userId como parâmetro

  QuizScreen({
    required this.questions,
    required this.modules,
    required this.currentModuleIndex,
    required this.userId, // Passe o userId ao criar a instância
  });

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

Future<String> _getStudentName(int userId) async {
  final dbService = DBService();
  final profile = await dbService.getProfile(userId);
  return profile?['name'] ?? 'Aluno';
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  late List<String?> _selectedAnswers;

  @override
  void initState() {
    super.initState();
    _selectedAnswers = List<String?>.filled(widget.questions.length, null);
  }

  void _submitQuiz() {
    _score = 0;
    for (int i = 0; i < widget.questions.length; i++) {
      if (_selectedAnswers[i] == widget.questions[i].correctAnswer) {
        _score++;
      }
    }

    String title;
    String message;
    bool passed = _score >= 3;

    if (passed) {
      title = 'Parabéns!';
      message = 'Você acertou $_score de ${widget.questions.length} questões!';
    } else {
      title = 'Tente Novamente!';
      message =
          'Você acertou $_score de ${widget.questions.length} questões. Você precisa acertar pelo menos 3 questões para passar.';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Fecha o diálogo
              if (passed) {
                if (widget.currentModuleIndex == widget.modules.length - 1) {
                  final studentName = await _getStudentName(widget.userId);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OnboardingCertificateScreen(
                        studentName: studentName,
                        userId: widget.userId,
                      ),
                    ),
                  );
                } else {
                  // Navega para o Dashboard com a aba de onboarding ativa
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardScreen(
                        userId: widget.userId,
                        initialTabIndex: 4, // Aba de onboarding
                      ),
                    ),
                    (route) => false,
                  );
                }
              } else {
                Navigator.of(context).pop(); // Fecha o diálogo se não passou
              }
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[_currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${_currentQuestionIndex + 1} of ${widget.questions.length}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(currentQuestion.questionText, style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            ...currentQuestion.options.map(
              (option) => RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: _selectedAnswers[_currentQuestionIndex],
                onChanged: (value) {
                  setState(() {
                    _selectedAnswers[_currentQuestionIndex] = value;
                  });
                },
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed:
                      _currentQuestionIndex > 0 ? _previousQuestion : null,
                  child: Text('Voltar'),
                ),
                ElevatedButton(
                  onPressed: _selectedAnswers[_currentQuestionIndex] != null
                      ? (_currentQuestionIndex == widget.questions.length - 1
                          ? _submitQuiz
                          : _nextQuestion)
                      : null,
                  child: Text(
                      _currentQuestionIndex == widget.questions.length - 1
                          ? 'Enviar'
                          : 'Avançar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
