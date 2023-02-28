import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:todo_new/components/scaffold_error_message.dart';
import 'package:todo_new/components/user_management.dart';
import 'package:todo_new/screens/intro_screenpage.dart';

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
              IntroScreen.id,
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios_new),
          onTap: () => Navigator.pushNamed(context, WelcomeScreen.id),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.indigo, Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: SafeArea(
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
                    AppText(
                      text: 'Get Started',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    AppText(
                      text: 'Sign up and get to work!',
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: AppText(
                            text: 'EmailAddress',
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
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
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: AppText(
                            text: 'Password',
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
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
                            showPassword ? Iconsax.eye4 : Iconsax.eye_slash4,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                        title: "Sign Up",
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
                    CustomButton(
                      title: 'Sign In',
                      color: Colors.teal,
                      ontap: () => Navigator.pushNamed(context, SignInPage.id),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
