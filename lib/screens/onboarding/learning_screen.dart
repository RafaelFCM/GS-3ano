// learning_screen.dart
import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/models/module_model.dart';
import 'package:pharmaconnect_project/screens/onboarding/welcome_screen.dart';
import 'quiz_screen.dart';

class LearningScreen extends StatefulWidget {
  final Module module;
  final List<Module> modules;
  final int currentModuleIndex;
  final int userId; // Adicione o userId como parâmetro

  LearningScreen({
    required this.module,
    required this.modules,
    required this.currentModuleIndex,
    required this.userId, // Recebe o userId
  });

  @override
  _LearningScreenState createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < widget.module.contents.length - 1) {
      setState(() {
        _currentPage++;
      });
    } else {
      // Navega para o QuizScreen com as perguntas específicas do módulo
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizScreen(
            questions: widget.module.questions,
            modules: widget.modules,
            currentModuleIndex: widget.currentModuleIndex,
            userId: widget.userId, // Passa o userId para o QuizScreen
          ),
        ),
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_currentPage + 1) / widget.module.contents.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.module.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey[300],
              color: Colors.blueAccent,
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  widget.module.contents[_currentPage],
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _previousPage,
                  child: Text('Voltar'),
                ),
                Text(
                  'Page ${_currentPage + 1} of ${widget.module.contents.length}',
                  style: TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: _nextPage,
                  child: Text(_currentPage == widget.module.contents.length - 1
                      ? 'Começar Quiz'
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
