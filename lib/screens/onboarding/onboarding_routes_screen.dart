import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/screens/onboarding/welcome_screen.dart';
import 'package:pharmaconnect_project/screens/onboarding/onboarding_certificate_screen.dart';

class OnboardingRoutesScreen extends StatelessWidget {
  final int userId; // Adicione o userId como parâmetro

  const OnboardingRoutesScreen({Key? key, required this.userId})
      : super(key: key); // Recebe o userId

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Onboarding App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(
            userId: userId), // Passa o userId para o WelcomeScreen
      },
    );
  }
}
