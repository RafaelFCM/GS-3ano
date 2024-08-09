import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      'question': 'Como posso resetar minha senha?',
      'answer':
          'Você pode resetar sua senha clicando em "Esqueci minha senha" na tela de login. Uma segunda opção é clicando em "Alterar senha" na tela de editar perfil, mas nesse caso você precisa ter conhecimento da sua senha atual.'
    },
    {
      'question': 'Como altero minhas informações de perfil?',
      'answer':
          'Você pode alterar suas informações de perfil acessando a página "Editar Perfil" nas configurações.'
    },
    {
      'question': 'Como posso entrar em contato com o suporte?',
      'answer':
          'Você pode entrar em contato com o suporte enviando um ticket através da página de suporte.'
    },
    {
      'question': 'Como vejo meus cursos favoritos?',
      'answer':
          'Você pode ver seus cursos favoritos na seção "Cursos Favoritos" no seu dashboard.'
    },
    {
      'question': 'Como altero minhas preferências de notificação?',
      'answer':
          'Você pode alterar suas preferências de notificação na página de configurações.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
        backgroundColor: Colors.blueGrey[300],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ExpansionTile(
              title: Text(
                faqs[index]['question']!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                ),
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    faqs[index]['answer']!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
