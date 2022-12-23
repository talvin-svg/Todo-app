import 'package:flutter/material.dart';
import 'package:newwer_todo/components/apptextfield.dart';

import '../components/app_text.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
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
  bool showPassword = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/todo-logo.png'),
            const Expanded(
              child: Text('The right app to get work done'),
            ),
            Expanded(
                child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppText(
                    text: 'USERNAME',
                  ),
                  const SizedBox(height: 10),
                  AppTextField(controller: _usernameController),
                  AppTextField(controller: _passwordController)
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
