import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo_new/async_actions.dart';
import 'package:todo_new/components/app_text.dart';
import 'package:todo_new/components/app_text_input_field.dart';
import 'package:todo_new/components/custom_button.dart';
import 'package:todo_new/components/scaffold_error_message.dart';
import 'package:todo_new/screens/intro_screenpage.dart';
import 'package:todo_new/screens/signup.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_new/screens/welcome_screen.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  static const String id = 'signiner';
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool showPassword = true;
  bool loading = false;
  bool onSuccess = false;
  late UserCredential result;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back_ios_new),
            onTap: () => Navigator.pushNamed(context, SignUpPage.id),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.teal, Colors.black],
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
                        text: 'Welcome Back!',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      AppText(
                        text: 'Sign in below and let\'s get back to work',
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
                          hintText: 'example@gmail.com',
                          controller: _emailController,
                          color: Theme.of(context).colorScheme.onBackground,
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
                          hintText: '*********',
                          controller: _passwordController,
                          obscureText: showPassword,
                          suffixFunction: () {
                            showPassword = !showPassword;
                            setState(() {});
                          },
                          suffixIcon: Icon(
                              showPassword ? Iconsax.eye4 : Iconsax.eye_slash4,
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                          title: "Sign In",
                          ontap: () {
                            signIn(
                                email: _emailController.text,
                                password: _passwordController.text,
                                context: context);
                          },
                          color: Colors.blue),
                      const SizedBox(
                        height: 30,
                      ),
                      AppText(
                        text: "Don't have an account yet?",
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        title: 'Sign Up',
                        color: Colors.teal,
                        ontap: () =>
                            Navigator.pushNamed(context, SignUpPage.id),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void finishSignin() {
    Future.delayed(const Duration(seconds: 4), (() {
      (onSuccess)
          ? Navigator.pushNamed(context, IntroScreen.id)
          : previewError(
              message: 'Account could not be signed into at this time',
              context: context);
    }));
  }
}
