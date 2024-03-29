import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:newwer_todo/components/custom_button.dart';
import '/components/app_text_input_field.dart';
import '../components/app_text.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Users");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Form(
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
                CustomButton(title: "SignUp", ontap: () {}, color: Colors.blue)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
