import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '/components/app_text_input_field.dart';
import '../components/app_text.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.light(),
        home: Scaffold(
          // backgroundColor: Theme.of(context).backgroundColor,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/todo-logo.png'),
                const AppText(text: 'The right app to Track progress!'),
              ],
            ),
          ),
        ));
  }
}
