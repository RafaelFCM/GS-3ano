import 'package:flutter/material.dart';

class PoliticaPrivacidadeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Política de Privacidade'),
        backgroundColor: Colors.blueGrey[300],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Política de Privacidade',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Última atualização: 1 de Janeiro de 2024',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20),
            Text(
              '1. Introdução',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[700],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Bem-vindo à nossa Política de Privacidade. A proteção dos seus dados é de extrema importância para nós. '
              'Esta política explica como coletamos, utilizamos, armazenamos e compartilhamos suas informações pessoais quando você usa nosso aplicativo.',
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            SizedBox(height: 20),
            Text(
              '2. Informações que Coletamos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[700],
              ),
            ),
            SizedBox(height: 10),
            Text(
              '2.1 Informações Pessoais: Coletamos informações como nome, endereço de e-mail, número de telefone e outras informações de contato quando você se cadastra em nosso aplicativo.',
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            SizedBox(height: 10),
            Text(
              '2.2 Informações de Uso: Podemos coletar informações sobre como você utiliza nosso aplicativo, incluindo as páginas que visita, o tempo que passa nelas, e outras interações.',
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            SizedBox(height: 10),
            Text(
              '2.3 Informações de Dispositivo: Coletamos dados sobre o dispositivo que você usa para acessar nosso aplicativo, como o modelo do dispositivo, sistema operacional, identificadores exclusivos e informações de rede móvel.',
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            SizedBox(height: 20),
            Text(
              '3. Como Utilizamos Suas Informações',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[700],
              ),
            ),
            SizedBox(height: 10),
            Text(
              '3.1 Para fornecer e manter nosso serviço: Utilizamos suas informações para operar e manter nosso aplicativo, assim como para entender e analisar como você usa o serviço.',
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            SizedBox(height: 10),
            Text(
              '3.2 Para melhorar o serviço: Usamos as informações coletadas para melhorar a funcionalidade e a qualidade do nosso aplicativo, incluindo a personalização da experiência do usuário.',
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            SizedBox(height: 10),
            Text(
              '3.3 Para comunicação: Podemos usar suas informações para enviar atualizações, newsletters, materiais promocionais e outras informações que possam ser do seu interesse.',
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            SizedBox(height: 20),
            Text(
              '4. Compartilhamento de Informações',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[700],
              ),
            ),
            SizedBox(height: 10),
            Text(
              '4.1 Com Terceiros: Não vendemos, trocamos ou alugamos suas informações pessoais para terceiros. Podemos compartilhar informações com parceiros de confiança que nos ajudam a operar nosso aplicativo, desde que concordem em manter essas informações confidenciais.',
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            SizedBox(height: 10),
            Text(
              '4.2 Em Caso de Requisição Legal: Podemos divulgar suas informações se exigido por lei ou em resposta a processos legais.',
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            SizedBox(height: 20),
            Text(
              '5. Segurança dos Dados',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[700],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Implementamos medidas de segurança adequadas para proteger suas informações contra acesso não autorizado, alteração, divulgação ou destruição. No entanto, nenhum método de transmissão ou armazenamento eletrônico é 100% seguro, e não podemos garantir segurança absoluta.',
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            SizedBox(height: 20),
            Text(
              '6. Seus Direitos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[700],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Você tem o direito de acessar, corrigir ou excluir suas informações pessoais a qualquer momento. Se desejar exercer esses direitos, entre em contato conosco por meio das informações de contato fornecidas abaixo.',
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            SizedBox(height: 20),
            Text(
              '7. Alterações a Esta Política',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[700],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Podemos atualizar esta Política de Privacidade periodicamente para refletir mudanças em nossas práticas ou em leis relevantes. Quando fizermos mudanças, atualizaremos a data da "Última atualização" no topo desta página.',
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            SizedBox(height: 20),
            Text(
              '8. Contato',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[700],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Se você tiver alguma dúvida ou preocupação sobre esta Política de Privacidade ou nossas práticas de privacidade, entre em contato conosco pelo e-mail: privacidade@eurofarma.com.br.',
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            SizedBox(height: 20),
            Text(
              '9. Consentimento',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[700],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Ao usar nosso aplicativo, você consente com a coleta e uso das informações conforme descrito nesta Política de Privacidade.',
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }
}
