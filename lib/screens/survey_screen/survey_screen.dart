import 'package:flutter/material.dart';

class SurveyScreen extends StatefulWidget {
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final _formKey = GlobalKey<FormState>();

  // Valores iniciais para as votações
  int _appSatisfaction = 5;
  int _dayToDayHelpfulness = 5;
  int _recommendationScore = 5;

  // Controladores de texto para os campos de feedback
  final TextEditingController _improvementController = TextEditingController();
  final TextEditingController _missingFeatureController =
      TextEditingController();
  final TextEditingController _removeFeatureController =
      TextEditingController();

  @override
  void dispose() {
    _improvementController.dispose();
    _missingFeatureController.dispose();
    _removeFeatureController.dispose();
    super.dispose();
  }

  void _submitSurvey() {
    if (_formKey.currentState!.validate()) {
      // Aqui você pode enviar os dados para um banco de dados, API, etc.
      print("Satisfação com o App: $_appSatisfaction");
      print("Ajuda no dia a dia: $_dayToDayHelpfulness");
      print("Recomendaria para outras empresas: $_recommendationScore");
      print("O que melhorar: ${_improvementController.text}");
      print("O que está faltando: ${_missingFeatureController.text}");
      print("O que poderia ser removido: ${_removeFeatureController.text}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Obrigado pelo seu feedback!')),
      );

      // Limpar os campos após o envio
      _improvementController.clear();
      _missingFeatureController.clear();
      _removeFeatureController.clear();
      setState(() {
        _appSatisfaction = 5;
        _dayToDayHelpfulness = 5;
        _recommendationScore = 5;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesquisa satisfação'),
        backgroundColor: Colors.blueGrey[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildSliderField(
                'Satisfação com o App (0 a 10)',
                _appSatisfaction,
                (value) => setState(() => _appSatisfaction = value),
              ),
              _buildSliderField(
                'Ele ajuda no seu dia a dia (0 a 10)',
                _dayToDayHelpfulness,
                (value) => setState(() => _dayToDayHelpfulness = value),
              ),
              _buildSliderField(
                'Recomendaria para outras empresas (0 a 10)',
                _recommendationScore,
                (value) => setState(() => _recommendationScore = value),
              ),
              _buildTextField(
                'O que acha que precisa melhorar no app?',
                _improvementController,
              ),
              _buildTextField(
                'O que está faltando no app?',
                _missingFeatureController,
              ),
              _buildTextField(
                'O que poderia ser removido do app?',
                _removeFeatureController,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitSurvey,
                  child: Text('Enviar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[300],
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliderField(
      String label, int currentValue, ValueChanged<int> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Slider(
          value: currentValue.toDouble(),
          min: 0,
          max: 10,
          divisions: 10,
          label: currentValue.toString(),
          onChanged: (double value) {
            onChanged(value.toInt());
          },
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        maxLines: null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }
}
