import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pharmaconnect_project/services/db_service.dart';

class PersonalityTestScreen extends StatefulWidget {
  final int userId;
  final VoidCallback onComplete;

  PersonalityTestScreen({required this.userId, required this.onComplete});

  @override
  _PersonalityTestScreenState createState() => _PersonalityTestScreenState();
}

class _PersonalityTestScreenState extends State<PersonalityTestScreen> {
  final List<String> _questions = [
    "Você faz novos amigos com frequência.",
    "Ideias complexas e inovadoras entusiasmam mais você do que ideias simples e diretas.",
    "Seus espaços de vida e de trabalho são limpos e organizados.",
    "Você normalmente mantém a calma, mesmo sob muita pressão.",
    "Você prioriza e planeja tarefas de forma eficaz, muitas vezes concluindo-as bem antes do prazo.",
    "As histórias e emoções das pessoas são mais importantes para você do que números ou dados.",
    "Você gosta de usar ferramentas de organização, como agendas e listas.",
    "Mesmo um erro pequeno pode fazer com que você duvide das suas habilidades e conhecimento.",
    "Você se sente confortável em se aproximar de alguém que considera interessante e iniciar uma conversa.",
    "Você prioriza os fatos sobre os sentimentos das pessoas ao determinar um curso de ação.",
    "Você gosta de participar de atividades em equipe.",
    "Você gosta de experimentar abordagens novas e ainda não comprovadas.",
    "Você tende a se preocupar com a possibilidade das coisas piorarem.",
    "Você não consegue se imaginar ganhando a vida escrevendo histórias de ficção.",
    "Você prefere fazer o que tem que ser feito para depois relaxar.",
    "Nas divergências, você prioriza provar seu ponto de vista em vez de preservar os sentimentos de outras pessoas.",
    "Você gosta de debater dilemas éticos.",
    "Você evita fazer chamadas telefônicas.",
    "Você gosta de explorar ideias e pontos de vista desconhecidos.",
    "Você considera que refletir sobre questões filosóficas abstratas é um desperdício de tempo.",
  ];

  final List<int> _answers =
      List.filled(20, 3); // Correctly filled for 20 questions
  String? _lastResult;
  String? _lastDescription;

  @override
  void initState() {
    super.initState();
    _loadLastResult();
  }

  Future<void> _loadLastResult() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastResult = prefs.getString('lastPersonalityResult');
      _lastDescription = prefs.getString('lastPersonalityDescription');
    });
  }

  Future<void> _saveLastResult(String result, String description) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastPersonalityResult', result);
    await prefs.setString('lastPersonalityDescription', description);
  }

  Future<void> _submit() async {
    int score =
        _answers.reduce((a, b) => a + b); // Total score based on 20 questions

    String personalityType;
    String description;

    // Correct score thresholds for 20 questions (max score 100 points)
    if (score <= 40) {
      personalityType = "ISTJ - O Inspetor";
      description = "Organizados, responsáveis, práticos, realistas.\n\n"
          "Pontos Fortes: Confiáveis, meticulosos, lógicos.\n\n"
          "Pontos a Melhorar: Podem ser inflexíveis, relutantes a mudanças.";
    } else if (score <= 50) {
      personalityType = "ISFJ - O Protetor";
      description = "Atenciosos, dedicados, detalhistas, leais.\n\n"
          "Pontos Fortes: Leais, práticos, trabalhadores.\n\n"
          "Pontos a Melhorar: Podem ser excessivamente altruístas, evitar conflitos.";
    } else if (score <= 60) {
      personalityType = "INFJ - O Conselheiro";
      description = "Intuitivos, visionários, inspiradores, sensíveis.\n\n"
          "Pontos Fortes: Criativos, idealistas, perspicazes.\n\n"
          "Pontos a Melhorar: Podem ser perfeccionistas, propensos ao esgotamento.";
    } else if (score <= 70) {
      personalityType = "INTJ - O Arquiteto";
      description = "Estratégicos, analíticos, independentes, decididos.\n\n"
          "Pontos Fortes: Planejadores, inovadores, confiantes.\n\n"
          "Pontos a Melhorar: Podem ser críticos, emocionalmente distantes.";
    } else if (score <= 80) {
      personalityType = "ISTP - O Artesão";
      description = "Práticos, observadores, independentes, analíticos.\n\n"
          "Pontos Fortes: Habilidosos, adaptáveis, tranquilos.\n\n"
          "Pontos a Melhorar: Podem ser impulsivos, difíceis de se conectar emocionalmente.";
    } else {
      personalityType = "ENTJ - O Comandante";
      description = "Estratégicos, decididos, francos, assertivos.\n\n"
          "Pontos Fortes: Líderes naturais, organizados, eficientes.\n\n"
          "Pontos a Melhorar: Podem ser dominadores, impacientes.";
    }

    _saveLastResult(personalityType, description);

    final dbService = DBService();
    await dbService.updateProfile(widget.userId, {
      'personalityType': personalityType,
    });

    widget.onComplete();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Resultado do Teste"),
          content: Text(
              "Seu tipo de personalidade é: $personalityType\n\n$description"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teste de Personalidade"),
        backgroundColor: Colors.blueGrey[300],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Responda às perguntas abaixo escolhendo uma opção entre Concordo e Discordo.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
            ..._questions.asMap().entries.map((entry) {
              int index = entry.key;
              String question = entry.value;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question,
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                    Slider(
                      value: _answers[index].toDouble(),
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: _answers[index] == 1
                          ? "Concordo totalmente"
                          : _answers[index] == 2
                              ? "Concordo em parte"
                              : _answers[index] == 3
                                  ? "Neutro"
                                  : _answers[index] == 4
                                      ? "Discordo em parte"
                                      : "Discordo totalmente",
                      activeColor: Colors.blueGrey[300],
                      inactiveColor: Colors.blueGrey[100],
                      onChanged: (value) {
                        setState(() {
                          _answers[index] = value.toInt();
                        });
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[300],
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  "Enviar",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            if (_lastResult != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Último resultado: $_lastResult\n\nDescrição: $_lastDescription",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
