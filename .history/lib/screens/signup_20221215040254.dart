import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';
import 'package:newwer_todo/components/custom_button.dart';
import 'package:newwer_todo/components/text_field_validator.dart';
import '../components/scaffold_error_message.dart';
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const AppText(
                    text: 'Sign up to start using todo app and get work done!'),
                const SizedBox(
                  height: 20,
                ),
                AppRichTextInputField(
                  context,
                  hintText: 'Username',
                  controller: _emailController,
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
                    showPassword ? Iconsax.eye_slash4 : Iconsax.eye4,
                    color: showPassword
                        ? Colors.black.withOpacity(0.5)
                        : Colors.pink,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                    title: "SignUp",
                    ontap: () async {
                      if (isLoginFieldsValid(
                          _emailController, _passwordController)) {
                        previewError(
                            context: context,
                            message:
                                "Please fill in all fields to create account!");
                      }
                      firebaseAuth
                          .createUserWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text)
                          .then((user) {
                        previewSuccess(
                            message: 'Acccount succesfully created!',
                            context: context);
                      });
                    },
                    color: Colors.blue)
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
