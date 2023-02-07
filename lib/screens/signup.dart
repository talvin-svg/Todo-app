import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:todo_new/components/scaffold_error_message.dart';
import 'package:todo_new/components/user_management.dart';

import 'package:todo_new/screens/homepage_revamped.dart';
import 'package:todo_new/screens/signin.dart';
import 'package:todo_new/screens/welcome_screen.dart';
import '../components/custom_button.dart';
import '../components/text_field_validator.dart';
import '/components/app_text_input_field.dart';
import '../components/app_text.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static const String id = 'signuper';
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool showPassword = true;
  bool onSuccess = false;
  late UserCredential result;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('newUsers');

  void pushToSigner() {
    Navigator.pushNamed(context, SignInPage.id);
  }

  @override
  void initState() {
    print('${FirebaseAuth.instance.currentUser?.uid}');
    super.initState();
  }

  void makeUser() {
    signUpUser(_emailController.text, _passwordController.text);

    Future.delayed(const Duration(seconds: 4), (() {
      (onSuccess)
          // ? Navigator.pushNamed(context, MyHomePage.id)
          ? Navigator.of(context).pushNamed(
              HompePageToo.id,
            )
          : previewError(
              message: 'Account could not be created at this time',
              context: context);
    }));
  }

  void signUpUser(String email, String password) async {
    if (!isSignUpFieldsValid(_emailController, _passwordController)) {
      previewError(
          context: context, message: 'Fields not filled in correctly!');
      return;
    }
    try {
      result = await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCredentials) {
        setState(() {
          onSuccess = true;
        });
        previewSuccess(
            message: 'Account Succesfully created', context: context);
        UserManagement().storeNewUser(userCredentials.user, context);
        return userCredentials;
      });

      return;
    } catch (e) {
      print(e.toString());
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomButton(
          color: Colors.teal,
          title: 'back',
          ontap: () => Navigator.popAndPushNamed(context, WelcomeScreen.id),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const AppText(
                      text:
                          'Sign up to start using todo app and get work done!'),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    child: AppRichTextInputField(
                      context,
                      hintText: 'Email',
                      controller: _emailController,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: AppRichTextInputField(
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
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                      title: "SignUp",
                      ontap: () {
                        makeUser();
                      },
                      color: Colors.blue),
                  const SizedBox(
                    height: 30,
                  ),
                  const AppText(
                    text: "Already have an account?",
                    color: Colors.teal,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: const AppText(
                      text: 'Login',
                      fontSize: 20,
                    ),
                    onTap: () {
                      try {
                        pushToSigner();
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
