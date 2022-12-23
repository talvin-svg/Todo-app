import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../screens/signup.dart';
import '/screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/welcomeScreen': (context) => const WelcomeScreen(),
        '/SignUpPage': (context) => const SignUpPage()
      },
      title: 'Flutter Demo',
      home: const SignUpPage(),
    );
  }
}
