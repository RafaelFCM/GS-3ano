import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/screens/course_detail_screen/course_detail_screen.dart';
import 'package:pharmaconnect_project/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:pharmaconnect_project/screens/login_screen/forgot_password_screen.dart';
import 'package:pharmaconnect_project/screens/personality_test_screen/personality_test_screen.dart';
import 'package:pharmaconnect_project/screens/ranking_screen/ranking.dart';
import 'package:pharmaconnect_project/screens/settings_screen/settings_screen.dart';
import 'package:pharmaconnect_project/screens/survey_screen/survey_screen.dart';
import 'package:pharmaconnect_project/screens/ticket_screen/ticket_screen.dart';

class ChatbotScreen extends StatefulWidget {
  final int userId; // Adicione o userId como parâmetro

  ChatbotScreen({required this.userId}); // Construtor para receber o userId

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  List<Map<String, dynamic>> conversation = [];

  @override
  void initState() {
    super.initState();
    _sendInitialMessage();
  }

  void _sendInitialMessage() {
    String initialResponseText = 'Como posso ajudar você hoje?';
    List<String> initialOptions = [
      'Recursos Humanos',
      'Informações da Empresa',
      'Política de Privacidade do App',
      'Ajuda com o App',
      'Pesquisa de Engajamento'
    ];

    setState(() {
      conversation.add({
        "sender": "bot",
        "text": initialResponseText,
        "options": initialOptions
      });
    });
  }

  void _sendMessage(String message) {
    setState(() {
      conversation.add({"sender": "user", "text": message});
      _getResponse(message);
    });
  }

  void _getResponse(String message) {
    String responseText;
    List<String> options = [];
    List<Map<String, dynamic>> linksAulas = [];
    List<Map<String, dynamic>> linksPaginas = [];

    switch (message) {
      case 'Recursos Humanos':
        responseText =
            'Clique no link para abrir um ticket direcionado ao RH da empresa.';
        linksPaginas = [
          {
            "text": "  Abrir Ticket",
            // "courseId": 10,
          }

          //PEDIR PRO CHAT DEPOIS, TEM QUE FAZER UM LINK SO QUE DE DIRECIONAMENTO DE PAGINA AO INVES DE COURSEID
        ];
        break;

      case 'Informações da Empresa':
        responseText = 'Sobre o que você gostaria de saber?';
        options = [
          'Missão e Visão',
          'Ferramentas e Sistemas',
          'Funções e Responsabilidades',
          'Nossos Negócios',
          'Políticas',
          'Demais informações'
        ];
        break;
      case 'Missão e Visão':
        // Ao invés de texto, vamos mostrar um link clicável
        responseText =
            'Clique no link para ver a lição de Missão e Visão no curso de Onboarding.';
        linksAulas = [
          {
            "text": "  Missão e Visão",
            "courseId": 10,
          }
        ];
        break;
      case 'Ferramentas e Sistemas':
        // Ao invés de texto, vamos mostrar um link clicável
        responseText =
            'Clique no link para ver a lição sobre Ferramentas e Sistemas no curso de Onboarding.';
        linksAulas = [
          {
            "text": "  Ferramentas e Sistemas",
            "courseId": 11,
          }
        ];
        break;
      case 'Funções e Responsabilidades':
        // Ao invés de texto, vamos mostrar um link clicável
        responseText =
            'Clique no link para ver a lição sobre suas Funções e Responsabilidades no curso de Onboarding.';
        linksAulas = [
          {
            "text": "  Funções e Responsabilidades",
            "courseId": 12,
          }
        ];
        break;
      case 'Nossos Negócios':
        // Ao invés de texto, vamos mostrar um link clicável
        responseText =
            'Clique no link para ver a lição sobre as áreas que atuamos no curso de Onboarding.';
        linksAulas = [
          {
            "text": "  Nossos Negócios",
            "courseId": 19,
          }
        ];
        break;
      case 'Políticas':
        // Ao invés de texto, vamos mostrar um link clicável
        responseText =
            'Clique no link para ver a lição sobre as políticas da empresa no curso de Onboarding.';
        linksAulas = [
          {
            "text": "  Políticas",
            "courseId": 15,
          }
        ];
        break;
      case 'Demais informações':
        // Ao invés de texto, vamos mostrar um link clicável
        responseText = 'Reveja nosso curso de Onboarding.';
        break;
      case 'Política de Privacidade do App':
        responseText =
            'Clique no link para ver a Política de Privacidade do App.';
        linksAulas = [
          {
            "text": "  Política de Privacidade",
            // "courseId": 10,
          }
        ];
        break;

      case 'Ajuda com o App':
        responseText = 'Como posso ajudar você com o aplicativo?';
        options = [
          'Como abrir ticket de suporte',
          'Como editar meu perfil',
          'Como alterar o idioma do App',
          'Como aumentar a fonte do App',
          'Como alterar minha senha',
          'Onde posso fazer o teste de personalidade',
          'Onde vejo o ranking dos usuários',
        ];
        break;
      case 'Como abrir ticket de suporte':
        responseText = 'Clique no link para abrir ticket de suporte.';
        linksPaginas = [
          {
            "text": "  Abrir ticket",
            // "courseId": 10,
          }
        ];
        break;
      case 'Como editar meu perfil':
        responseText = 'Clique no link para editar meu perfil.';
        linksPaginas = [
          {
            "text": "  Editar perfil",
            // "courseId": 10,
          }
        ];
        break;
      case 'Como alterar o idioma do App':
        responseText = 'Clique no link para alterar o idioma do App.';
        linksPaginas = [
          {
            "text": "  Alterar o idioma",
            // "courseId": 10,
          }
        ];
        break;
      case 'Como aumentar a fonte do App':
        responseText = 'Clique no link para aumentar a fonte do App.';
        linksPaginas = [
          {
            "text": "  Aumentar a fonte",
            // "courseId": 10,
          }
        ];
        break;
      case 'Como alterar minha senha':
        responseText = 'Clique no link para alterar minha senha.';
        linksPaginas = [
          {
            "text": "  Alterar senha",
            // "courseId": 10,
          }
        ];
        break;
      case 'Onde posso fazer o teste de personalidade':
        responseText = 'Clique no link para fazer o teste de personalidade.';
        linksPaginas = [
          {
            "text": "  Teste de personalidade",
            // "courseId": 10,
          }
        ];
        break;
      case 'Onde vejo o ranking dos usuários':
        responseText = 'Clique no link para ver ranking dos usuários.';
        linksPaginas = [
          {
            "text": "  Ver ranking",
            // "courseId": 10,
          }
        ];
        break;

      case 'Pesquisa de Engajamento':
        responseText =
            'Gostaria de avaliar o nosso App e sua utilização? Clique no link.';
        linksPaginas = [
          {
            "text": "  Avaliar o App",
            // "courseId": 10,
          }
        ];
        break;

      case 'Voltar ao Início':
        responseText = 'Como posso ajudar você hoje?';
        options = [
          'Recursos Humanos',
          'Informações da Empresa',
          'Política de Privacidade do App',
          'Ajuda com o App',
          'Pesquisa de Engajamento',
        ];
        break;

      default:
        responseText = 'Desculpe, não entendi sua escolha.';
        options = ['Voltar ao Início'];
        break;
    }

    setState(() {
      conversation.add({
        "sender": "bot",
        "text": responseText,
        "options": options,
        "linksAulas": linksAulas,
        "linksPaginas": linksPaginas
      });
    });
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: message['sender'] == 'user'
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
          decoration: BoxDecoration(
            color: message['sender'] == 'user'
                ? Colors.blueAccent
                : Colors.grey[700],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            message['text'],
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildOptions(List<String> options) {
    return Wrap(
      children: options.map((option) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ElevatedButton(
            onPressed: () => _sendMessage(option),
            child: Text(option),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLinksAulas(List<Map<String, dynamic>> linksAulas) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: linksAulas.map((link) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
            onTap: () {
              // Navegação para a página CourseDetailScreen com courseId
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailScreen(
                    courseId: link['courseId'],
                    userId: widget.userId,
                  ),
                ),
              );
            },
            child: Text(
              link['text'],
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLinksPaginas(List<Map<String, dynamic>> linksPaginas) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: linksPaginas.map((link) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
            onTap: () {
              // Navegação para diferentes páginas com base no texto do link
              _navigateToPage(link['text']);
            },
            child: Text(
              link['text'],
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _navigateToPage(String linkText) {
    switch (linkText.trim()) {
      case "Abrir ticket":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TicketScreen(),
          ),
        );
        break;
      case "Editar perfil":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditProfileScreen(userId: widget.userId),
          ),
        );
        break;
      case "Alterar o idioma":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SettingsScreen(),
          ),
        );
        break;
      case "Aumentar a fonte":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SettingsScreen(),
          ),
        );
        break;
      case "Alterar senha":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ForgotPasswordScreen(),
          ),
        );
        break;
      case "Teste de personalidade":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonalityTestScreen(
              userId: widget.userId,
              onComplete: () {},
            ),
          ),
        );
        break;
      case "Ver ranking":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RankingScreen(),
          ),
        );
        break;
      case "Avaliar o App":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SurveyScreen(),
          ),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Página não encontrada para $linkText')),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: conversation.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (conversation[index]['text'] != '')
                      _buildMessage(conversation[index]),
                    if (conversation[index]['sender'] == 'bot' &&
                        conversation[index]['options'] != null)
                      _buildOptions(conversation[index]['options']),
                    if (conversation[index]['sender'] == 'bot' &&
                        conversation[index]['linksAulas'] != null)
                      _buildLinksAulas(conversation[index]['linksAulas']),
                    if (conversation[index]['sender'] == 'bot' &&
                        conversation[index]['linksPaginas'] != null)
                      _buildLinksPaginas(conversation[index]['linksPaginas']),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
