import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo_new/async_actions.dart';
import 'package:todo_new/components/constants.dart';
import 'package:todo_new/components/scaffold_error_message.dart';
import 'package:todo_new/screens/homepage.dart';
import 'package:todo_new/screens/signup.dart';
import '../components/custom_button.dart';
import '../components/text_field_validator.dart';
import '/components/app_text_input_field.dart';
import '../components/app_text.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  void loginUser(String email, String password) async {
    if (!isLoginFieldsValid(_emailController, _passwordController)) {
      previewError(
          context: context, message: 'Fields not filled in correctly!');
      return;
    }
    try {
      result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      String user = result.user!.uid;

      setState(() {
        onSuccess = true;
      });
      previewSuccess(
          message: 'Welcome Back!, Lets get to work', context: context);

      Future.delayed(const Duration(seconds: 4), (() {
        (onSuccess)
            ? Navigator.pushNamed(context, MyHomePage.id)
            : previewError(
                message: 'Account could not be created at this time',
                context: context);
      }));
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
            ontap: () => Navigator.pop(context),
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
                    const AppText(text: 'Sign in to resume getting work done!'),
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
                        title: "Sign In",
                        ontap: () {
                          loginUser(
                              _emailController.text, _passwordController.text);
                        },
                        color: Colors.blue),
                    const SizedBox(
                      height: 30,
                    ),
                    const AppText(
                      text: "Don't have an account yet?",
                      color: Colors.teal,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      title: 'SignUp',
                      color: Colors.teal,
                      ontap: () => routeToSignup(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void routeToSignup() {
    if (onSuccess) Navigator.pushNamed(context, SignUpPage.id);
  }

  void finishSignin() {
    Future.delayed(const Duration(seconds: 4), (() {
      (onSuccess)
          ? Navigator.pushNamed(context, MyHomePage.id)
          : previewError(
              message: 'Account could not be signed into at this time',
              context: context);
    }));
  }
}
