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
    "Você geralmente se orienta mais por aquilo que ressoa emocionalmente com você do que por argumentos factuais.",
    "Seus espaços de vida e de trabalho são limpos e organizados.",
    "Você normalmente mantém a calma, mesmo sob muita pressão.",
    "Você considera a ideia de fazer networking ou de se promover para estranhos uma tarefa difícil.",
    "Você prioriza e planeja tarefas de forma eficaz, muitas vezes concluindo-as bem antes do prazo.",
    "As histórias e emoções das pessoas são mais importantes para você do que números ou dados.",
    "Você gosta de usar ferramentas de organização, como agendas e listas.",
    "Mesmo um erro pequeno pode fazer com que você duvide das suas habilidades e conhecimento.",
    "Você se sente confortável em se aproximar de alguém que considera interessante e iniciar uma conversa.",
    "Você não se interessa muito por discussões sobre as diversas interpretações de trabalhos criativos.",
    "Você prioriza os fatos sobre os sentimentos das pessoas ao determinar um curso de ação.",
    "Muitas vezes você segue o seu dia sem se programar.",
    "Você quase nunca se preocupa em causar uma boa impressão nas pessoas que conhece.",
    "Você gosta de participar de atividades em equipe.",
    "Você gosta de experimentar abordagens novas e ainda não comprovadas.",
    "Você prioriza a sensibilidade em vez de franqueza pura.",
    "Você busca ativamente novas experiências e áreas de conhecimento para explorar.",
    "Você tende a se preocupar com a possibilidade das coisas piorarem.",
    "Você gosta mais de hobbies ou atividades individuais do que em grupo.",
    "Você não consegue se imaginar ganhando a vida escrevendo histórias de ficção.",
    "Você privilegia a eficiência nas decisões, mesmo que isso signifique desconsiderar alguns aspectos emocionais.",
    "Você prefere fazer o que tem que ser feito para depois relaxar.",
    "Nas divergências, você prioriza provar seu ponto de vista em vez de preservar os sentimentos de outras pessoas.",
    "Você geralmente espera que os outros se apresentem primeiro em eventos sociais.",
    "Seu humor pode oscilar muito rápido.",
    "Você não se deixa influenciar facilmente por argumentos emocionais.",
    "Você normalmente acaba fazendo as coisas no último minuto possível.",
    "Você gosta de debater dilemas éticos.",
    "Você normalmente prefere estar na companhia de outras pessoas do que sozinho.",
    "Você fica entediado ou desinteressado quando uma conversa se torna muito teórica.",
    "Quando fatos e sentimentos entram em conflito, você geralmente segue seu coração.",
    "Você tem dificuldade de manter um cronograma consistente de trabalho ou estudo.",
    "Você quase nunca tem dúvidas das escolhas que fez.",
    "Seus amigos descreveriam você como uma pessoa animada e extrovertida.",
    "Você se interessa por várias formas de expressão criativa, como a escrita.",
    "Você geralmente baseia suas escolhas em fatos objetivos em vez de impressões emocionais.",
    "Você gosta de ter uma lista de tarefas para cada dia.",
    "Você quase nunca se sente inseguro.",
    "Você evita fazer chamadas telefônicas.",
    "Você gosta de explorar ideias e pontos de vista desconhecidos.",
    "Você consegue se conectar facilmente com pessoas que acabou de conhecer.",
    "Se seus planos são interrompidos, a sua principal prioridade é retomá-los o mais rapidamente possível.",
    "Você ainda se incomoda com erros que cometeu no passado.",
    "Você não tem muito interesse em discutir teorias sobre como será o mundo no futuro.",
    "As suas emoções têm mais controle sobre você do que você sobre elas.",
    "Ao tomar decisões, você se concentra mais em como as pessoas afetadas podem se sentir do que no que é mais lógico ou eficiente.",
    "O seu estilo de trabalho tende a ser mais marcado por picos espontâneos de energia do que esforços organizados e consistentes.",
    "Quando uma pessoa tem uma opinião positiva sobre você, você se pergunta quanto tempo levará até que ela se decepcione.",
    "Você adoraria ter um emprego no qual tivesse que trabalhar sozinho a maior parte do tempo.",
    "Você considera que refletir sobre questões filosóficas abstratas é um desperdício de tempo.",
    "Você prefere ambientes movimentados e agitados do que lugares tranquilos e íntimos.",
    "Se uma decisão parece certa, muitas vezes você age de acordo com ela sem precisar de mais evidências.",
    "Você costuma se sentir sobrecarregado.",
    "Você conclui tarefas de maneira metódica, sem pular nenhuma etapa.",
    "Você prefere tarefas que exijam soluções criativas em vez de seguir etapas concretas.",
    "Ao fazer uma escolha, é mais provável que você confie na intuição emocional do que no raciocínio lógico.",
    "Você tem dificuldade com prazos.",
    "Você confia que as coisas vão dar certo para você.",
  ];

  final List<int> _answers =
      List.filled(60, 3); // 60 perguntas, todas iniciadas em 3 (neutro)
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
    int score = _answers.reduce((a, b) => a + b);

    String personalityType;
    String description;

    if (score <= 120) {
      personalityType = "ISTJ - O Inspetor";
      description = "Organizados, responsáveis, práticos, realistas.\n\n"
          "Pontos Fortes: Confiáveis, meticulosos, lógicos.\n\n"
          "Pontos a Melhorar: Podem ser inflexíveis, relutantes a mudanças.";
    } else if (score <= 140) {
      personalityType = "ISFJ - O Protetor";
      description = "Atenciosos, dedicados, detalhistas, leais.\n\n"
          "Pontos Fortes: Leais, práticos, trabalhadores.\n\n"
          "Pontos a Melhorar: Podem ser excessivamente altruístas, evitar conflitos.";
    } else if (score <= 160) {
      personalityType = "INFJ - O Conselheiro";
      description = "Intuitivos, visionários, inspiradores, sensíveis.\n\n"
          "Pontos Fortes: Criativos, idealistas, perspicazes.\n\n"
          "Pontos a Melhorar: Podem ser perfeccionistas, propensos ao esgotamento.";
    } else if (score <= 180) {
      personalityType = "INTJ - O Arquiteto";
      description = "Estratégicos, analíticos, independentes, decididos.\n\n"
          "Pontos Fortes: Planejadores, inovadores, confiantes.\n\n"
          "Pontos a Melhorar: Podem ser críticos, emocionalmente distantes.";
    } else if (score <= 200) {
      personalityType = "ISTP - O Artesão";
      description = "Práticos, observadores, independentes, analíticos.\n\n"
          "Pontos Fortes: Habilidosos, adaptáveis, tranquilos.\n\n"
          "Pontos a Melhorar: Podem ser impulsivos, difíceis de se conectar emocionalmente.";
    } else if (score <= 220) {
      personalityType = "ISFP - O Compositor";
      description = "Sensíveis, modestos, adaptáveis, tranquilos.\n\n"
          "Pontos Fortes: Artísticos, flexíveis, compreensivos.\n\n"
          "Pontos a Melhorar: Podem ser indecisos, evitar conflitos.";
    } else if (score <= 240) {
      personalityType = "INFP - O Mediador";
      description = "Idealistas, criativos, leais, reflexivos.\n\n"
          "Pontos Fortes: Empáticos, apaixonados, leais.\n\n"
          "Pontos a Melhorar: Podem ser excessivamente idealistas, propensos a se isolar.";
    } else if (score <= 260) {
      personalityType = "INTP - O Lógico";
      description = "Analíticos, independentes, inovadores, reservados.\n\n"
          "Pontos Fortes: Racionais, inventivos, curiosos.\n\n"
          "Pontos a Melhorar: Podem ser distantes, indecisos.";
    } else if (score <= 280) {
      personalityType = "ESTP - O Empreendedor";
      description = "Energéticos, adaptáveis, observadores, diretos.\n\n"
          "Pontos Fortes: Realistas, espontâneos, enérgicos.\n\n"
          "Pontos a Melhorar: Podem ser imprudentes, impacientes.";
    } else if (score <= 300) {
      personalityType = "ESFP - O Animador";
      description = "Sociáveis, otimistas, práticos, animados.\n\n"
          "Pontos Fortes: Entusiasmáticos, sensíveis, espontâneos.\n\n"
          "Pontos a Melhorar: Podem ser distraídos, avessos ao planejamento.";
    } else if (score <= 320) {
      personalityType = "ENFP - O Inspirador";
      description = "Entusiastas, criativos, sociáveis, espontâneos.\n\n"
          "Pontos Fortes: Energéticos, imaginativos, independentes.\n\n"
          "Pontos a Melhorar: Podem ser dispersos, superestimular.";
    } else if (score <= 340) {
      personalityType = "ENTP - O Visionário";
      description = "Inovadores, analíticos, enérgicos, argumentativos.\n\n"
          "Pontos Fortes: Racionais, criativos, otimistas.\n\n"
          "Pontos a Melhorar: Podem ser argumentativos, impacientes.";
    } else if (score <= 360) {
      personalityType = "ESTJ - O Diretor";
      description = "Práticos, organizados, decididos, tradicionais.\n\n"
          "Pontos Fortes: Eficientes, confiáveis, diretos.\n\n"
          "Pontos a Melhorar: Podem ser inflexíveis, dominadores.";
    } else if (score <= 380) {
      personalityType = "ESFJ - O Provedor";
      description = "Sociáveis, responsáveis, cooperativos, organizados.\n\n"
          "Pontos Fortes: Leais, práticos, prestativos.\n\n"
          "Pontos a Melhorar: Podem ser excessivamente preocupados com a aprovação dos outros, avessos a conflitos.";
    } else if (score <= 400) {
      personalityType = "ENFJ - O Protagonista";
      description = "Carismáticos, inspiradores, idealistas, organizados.\n\n"
          "Pontos Fortes: Empáticos, líderes naturais, inspiradores.\n\n"
          "Pontos a Melhorar: Podem ser excessivamente idealistas, propensos ao esgotamento.";
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
