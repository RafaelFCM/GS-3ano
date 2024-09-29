// ignore_for_file: unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/services/db_service.dart';
import 'screens/login_screen/login_screen.dart';
import 'screens/dashboard_screen/dashboard_screen.dart';
import 'package:pharmaconnect_project/screens/profile_screen/profile_screen.dart';
import 'package:pharmaconnect_project/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:pharmaconnect_project/models/settings_model.dart';
import 'package:pharmaconnect_project/screens/settings_screen/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


// Future<void> main() async {
// //   // Inicialize o suporte para FFI
// //   sqfliteFfiInit();
// //   // Configure o databaseFactory para usar o FFI
// //   databaseFactory = databaseFactoryFfi;

// //   WidgetsFlutterBinding.ensureInitialized();

//   await DBService().deleteDatabase();
// //   //DEIXAR COMENTADO SE NÃO REFAZ O BANCO DE DADOS PARA PADRÃO

//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => SettingsModel()),
//       ],
//       child: MyApp(),
//     ),
//   );
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBService().deleteDatabase();
  //DEIXAR COMENTADO SE NÃO REFAZ O BANCO DE DADOS PARA PADRÃO

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PharmaConnect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Usando uma tela inicial para redirecionamento
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
    final int? userId = prefs.getInt('userId');

    if (isAuthenticated && userId != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(userId: userId),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
