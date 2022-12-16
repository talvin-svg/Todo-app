import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_new/screens/homepage.dart';
import 'package:todo_new/screens/signin.dart';
import '/screens/signup.dart';
import '/screens/welcome_screen.dart';
import '/components/constants.dart';

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
        welcomeScreen: (context) => const WelcomeScreen(),
        signUper: (context) => const SignUpPage(),
        signIner: (context) => const SignInPage(),
        homey: (context) => const MyHomePage(title: 'Create first TODO')
      },
      title: 'Flutter Demo',
      home: const WelcomeScreen(),
    );
  }
}
