import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_new/screens/homepage.dart';
import 'package:todo_new/screens/signin.dart';
import '/screens/signup.dart';
import '/screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.name, this.id}) : super(key: key);
  final String? name;
  final String? id;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onUnknownRoute: (settings) => MaterialPageRoute(
          settings: settings, builder: (context) => const WelcomeScreen()),
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        SignUpPage.id: (context) => const SignUpPage(),
        SignInPage.id: (context) => const SignInPage(),
        MyHomePage.id: (context) => const MyHomePage(),
      },
      title: 'Flutter Demo',
      home: const MyHomePage(),
    );
  }
}
