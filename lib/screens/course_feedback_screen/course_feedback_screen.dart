import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/screens/certificate_screen/certificate_screen.dart';
import 'package:pharmaconnect_project/services/db_service.dart';
import 'package:flutter/services.dart';

class FeedbackScreen extends StatelessWidget {
  final int courseId;
  final int userId;

  FeedbackScreen({required this.courseId, required this.userId});

  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _structureController = TextEditingController();
  final TextEditingController _materialsController = TextEditingController();
  final TextEditingController _knowledgeController = TextEditingController();
  final TextEditingController _didacticsController = TextEditingController();
  final TextEditingController _recommendController = TextEditingController();

  Future<String> _getStudentName(int userId) async {
    final dbService = DBService();
    final profile = await dbService.getProfile(userId);
    return profile?['name'] ?? 'Aluno';
  }

  void _submitFeedback(BuildContext context) async {
    if (_contentController.text.isEmpty ||
        _structureController.text.isEmpty ||
        _materialsController.text.isEmpty ||
        _knowledgeController.text.isEmpty ||
        _didacticsController.text.isEmpty ||
        _recommendController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    final int contentRating = int.parse(_contentController.text);
    final int structureRating = int.parse(_structureController.text);
    final int materialsRating = int.parse(_materialsController.text);
    final int knowledgeRating = int.parse(_knowledgeController.text);
    final int didacticsRating = int.parse(_didacticsController.text);
    final int recommendRating = int.parse(_recommendController.text);

    if (contentRating < 0 ||
        contentRating > 10 ||
        structureRating < 0 ||
        structureRating > 10 ||
        materialsRating < 0 ||
        materialsRating > 10 ||
        knowledgeRating < 0 ||
        knowledgeRating > 10 ||
        didacticsRating < 0 ||
        didacticsRating > 10 ||
        recommendRating < 0 ||
        recommendRating > 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('As avaliações devem ser entre 0 e 10.')),
      );
      return;
    }

    // Lógica para salvar o feedback pode ser implementada aqui

    // Após enviar o feedback, navega para a tela de certificado
    final studentName = await _getStudentName(userId);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CertificateScreen(
          courseId: courseId,
          studentName: studentName,
          userId: userId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avalie o Curso'),
        backgroundColor: Colors.blueGrey[300],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Avaliação do Curso',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[700],
              ),
            ),
            SizedBox(height: 10),
            _buildFeedbackField(
              'Como você avalia a qualidade do conteúdo do curso? (0-10)',
              _contentController,
            ),
            _buildFeedbackField(
              'Como você avalia a organização e a estrutura do curso? (0-10)',
              _structureController,
            ),
            _buildFeedbackField(
              'Como você avalia a qualidade dos materiais de apoio (apostilas, slides, vídeos, etc.)? (0-10)',
              _materialsController,
            ),
            _buildFeedbackField(
              'Como você avalia o conhecimento do instrutor sobre o assunto? (0-10)',
              _knowledgeController,
            ),
            _buildFeedbackField(
              'Como você avalia a didática do instrutor? (0-10)',
              _didacticsController,
            ),
            _buildFeedbackField(
              'Em que medida você recomendaria este curso para outros? (0-10)',
              _recommendController,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => _submitFeedback(context),
                child: Text('Enviar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackField(
      String question, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(fontSize: 16, color: Colors.blueGrey[700]),
          ),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              LengthLimitingTextInputFormatter(2), // Limitar a 2 caracteres
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Digite sua avaliação (0-10)',
            ),
          ),
        ],
      ),
    );
  }
}
