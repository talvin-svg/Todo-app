import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark(),
      home: const SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              'Welcome To TODO APP',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text('If this is your first time sign up to use free todo app'),
                GestureDetector(
                  child: Text("sign in"),
                  onTap: (() {}),
                )
              ],
            ),
            Expanded(
                child: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
