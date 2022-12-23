import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: SafeArea(
            child: Column(
              children: const [
                Text(
                  'Welcome To TODO APP',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
    );
  }
}
