import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importe isso para usar o TextInputFormatter

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_emailChanged);
  }

  void _emailChanged() {
    setState(() {
      _isButtonDisabled = !isValidEmail(_emailController.text);
    });
  }

  bool isValidEmail(String email) {
    return email.isNotEmpty && email.endsWith('@eurofarma.com');
  }

  void _sendPasswordResetEmail() {
    final email = _emailController.text;

    if (!isValidEmail(email)) {
      _showAlert('Email deve terminar com @eurofarma.com');
      return; // Retorna se o email não for válido
    }

    // Aqui você adiciona a lógica para enviar o email de redefinição de senha
    // Pode ser uma chamada de API ou qualquer outra lógica necessária

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Resetar Senha'),
          content: Text('O link para resetar a senha foi enviado para $email'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
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
        title: Text('Esqueci minha senha'),
        backgroundColor: Colors.blueGrey[300],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Recuperar Senha',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                  fontFamily: 'SansitaSwashed',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Digite seu email para enviar o link de redefinição de senha.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              _buildTextField(
                controller: _emailController,
                label: 'Email',
                hintText: 'Digite seu email',
                onSubmitted: (_) => _sendPasswordResetEmail(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isButtonDisabled ? null : _sendPasswordResetEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[300],
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  'Enviar Link',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    bool obscureText = false,
    void Function(String)? onSubmitted,
  }) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        setState(() {
          _isButtonDisabled = !isValidEmail(value);
        });
      },
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      obscureText: obscureText,
      keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'[ ]')), // Bloqueia espaços
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
