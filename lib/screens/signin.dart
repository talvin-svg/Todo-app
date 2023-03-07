import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:iconsax/iconsax.dart';
import 'package:redux/redux.dart';
import 'package:todo_new/Appstate/appstate.dart';
import 'package:todo_new/async_actions.dart';
import 'package:todo_new/components/app_text.dart';
import 'package:todo_new/components/app_text_input_field.dart';
import 'package:todo_new/components/custom_button.dart';
import 'package:todo_new/components/rounded_button.dart';
import 'package:todo_new/components/scaffold_error_message.dart';
import 'package:todo_new/list/constants.dart';
import 'package:todo_new/screens/intro_screenpage.dart';
import 'package:todo_new/screens/signup.dart';

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

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: (Store<AppState> store) =>
          _ViewModel(context: context, store: store),
      builder: (BuildContext context, _ViewModel vm) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back_ios_new),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: body(context, vm),
      ),
    );
  }

  Widget body(BuildContext context, _ViewModel vm) {
    return Container(
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
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RoundedButton(
                      loadingKey: signUserLoadingKey,
                      text: "Sign In",
                      onTap: () {
                        signIn(
                            loadingKey: signUserLoadingKey,
                            store: vm.store,
                            email: _emailController.text,
                            password: _passwordController.text,
                            context: context,
                            onSuccess: () {
                              previewSuccess(
                                  message: 'Welcome Back!', context: context);
                              Navigator.pushNamed(context, IntroScreen.id);
                            });
                      },
                      backgroundColor: Colors.blue),
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
                    ontap: () => Navigator.pushNamed(context, SignUpPage.id),
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

class _ViewModel {
  final BuildContext context;
  final Store<AppState> store;

  const _ViewModel({required this.context, required this.store});
}
