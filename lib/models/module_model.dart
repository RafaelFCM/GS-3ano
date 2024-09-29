import 'question_model.dart';

class Module {
  final String title;
  final List<String> contents;
  final List<Question> questions;

  Module({
    required this.title,
    required this.contents,
    required this.questions,
  });
}
