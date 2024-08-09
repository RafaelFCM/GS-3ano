import 'package:flutter/material.dart';
import 'dart:math';

class SupportScreen extends StatefulWidget {
  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  List<Map<String, String>> _tickets = [];

  void _enviarTicket() {
    String id = Random().nextInt(100000).toString();
    String subject = _subjectController.text;
    String message = _messageController.text;

    setState(() {
      _tickets.add({
        'id': id,
        'subject': subject,
        'message': message,
        'status': 'Em Aberto',
      });

      _subjectController.clear();
      _messageController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ticket enviado com sucesso!')),
    );
  }

  void _toggleStatus(int index) {
    setState(() {
      if (_tickets[index]['status'] == 'Em Aberto') {
        _tickets[index]['status'] = 'Concluído';
      } else {
        _tickets[index]['status'] = 'Em Aberto';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suporte'),
        backgroundColor: Colors.blueGrey[300],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Envie aqui sua requisição'),
            SizedBox(height: 10),
            _buildTextField(controller: _subjectController, label: 'Assunto'),
            SizedBox(height: 10),
            _buildTextField(
              controller: _messageController,
              label: 'Mensagem',
              maxLines: 5,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _enviarTicket,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[300],
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('Enviar'),
              ),
            ),
            SizedBox(height: 20),
            _buildSectionTitle('Histórico de Tickets Enviados'),
            SizedBox(height: 10),
            ..._tickets.asMap().entries.map((entry) {
              int index = entry.key;
              var ticket = entry.value;
              return Card(
                child: ListTile(
                  title: Text('ID: ${ticket['id']} - ${ticket['subject']}'),
                  subtitle: Text(ticket['message']!),
                  trailing: GestureDetector(
                    onTap: () => _toggleStatus(index),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: ticket['status'] == 'Em Aberto'
                            ? Colors.yellow
                            : Colors.green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        ticket['status']!,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
