import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/screens/dashboard_screen/dashboard_screen.dart';
import 'package:pharmaconnect_project/screens/suporte/support_dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pharmaconnect_project/services/db_service.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _login(BuildContext context) async {
    String email = _usernameController.text;
    String password = _passwordController.text;

    if (!email.endsWith('@eurofarma.com')) {
      _showAlert('Email deve terminar com @eurofarma.com');
      return;
    }

    final db = DBService();
    final user = await db.loginUser(email, password);

    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isAuthenticated', true);
      await prefs.setInt('userId', user['userId']);

      if (email == 'suporte@eurofarma.com') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SupportDashboardScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardScreen(userId: user['userId']),
          ),
        );
      }
    } else {
      _showAlert('Email ou senha inválidos');
    }
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
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Bem-Vindo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                  fontFamily: 'SansitaSwashed',
                ),
              ),
              Container(
                width: 300,
                height: 300,
                child: Image.asset('assets/images/logo.jpg'),
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: _usernameController,
                label: 'Email corporativo',
                hintText: 'Digite seu email',
                onSubmitted: (_) => _login(context),
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: _passwordController,
                label: 'Senha',
                hintText: 'Digite sua senha',
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                onSubmitted: (_) => _login(context),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen()),
                    );
                  },
                  child: Text(
                    'Esqueci minha senha',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _login(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[300],
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  'Login',
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
    Widget? suffixIcon,
    void Function(String)? onSubmitted,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        suffixIcon: suffixIcon,
      ),
      obscureText: obscureText,
      onSubmitted: onSubmitted,
    );
  }
}
