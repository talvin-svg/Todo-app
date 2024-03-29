import 'package:flutter/material.dart';
import '/components/app_text_input_field.dart';
import '/components/apptextfield.dart';
import '../components/app_text.dart';
import '../components/app_text_input_field.dart';

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
            const AppText(text: 'The right app to Track progress!'),
            Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppRichTextInputField(
                    context,
                    hintText: 'Username',
                    controller: _usernameController,
                    color: Colors.black87,
                  ),
                  const SizedBox(height: 10),
                  AppRichTextInputField(
                    context,
                    hintText: 'Password',
                    controller: _passwordController,
                    obscureText: showPassword,
                    suffixFunction: () {
                      showPassword = !showPassword;
                      setState(() {});
                    },
                    suffixIcon: Icon(
                      showPassword ? Icons.hide_image : Icons.image,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
