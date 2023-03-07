import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:iconsax/iconsax.dart';
import 'package:redux/redux.dart';
import 'package:todo_new/Appstate/appstate.dart';
import 'package:todo_new/async_actions.dart';
import 'package:todo_new/components/rounded_button.dart';
import 'package:todo_new/components/scaffold_error_message.dart';
import 'package:todo_new/list/constants.dart';
import 'package:todo_new/screens/signin.dart';

import '../components/text_field_validator.dart';
import '/components/app_text_input_field.dart';
import '../components/app_text.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static const String id = 'signuper';
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool showPassword = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
        converter: (Store<AppState> store) =>
            _ViewModel(context: context, store: store),
        builder: (BuildContext context, _ViewModel vm) {
          return Scaffold(
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
          );
        });
  }

  Widget body(BuildContext context, _ViewModel vm) {
    return Container(
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
                  signupButton(context, vm.store),
                  const SizedBox(
                    height: 30,
                  ),
                  AppText(
                    text: "Already have an account?",
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: const AppText(
                      fontSize: 18,
                      color: Colors.teal,
                      text: 'Sign in',
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, SignInPage.id);
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

  void makeUser(Store<AppState> store) async {
    if (!isSignUpFieldsValid(_emailController, _passwordController)) {
      previewError(
          message: 'Please fill in all fields correctly', context: context);
    }

    return signUpUser(
      loadingKey: createUserLoadingKey,
      email: _emailController.text,
      password: _passwordController.text,
      context: context,
      store: store,
    );
  }

  signupButton(BuildContext context, Store<AppState> store) {
    return RoundedButton(
        loadingKey: createUserLoadingKey,
        width: 100,
        text: 'Sign Up',
        onTap: () => makeUser(store),
        isPill: true,
        backgroundColor: Colors.blue);
  }
}

class _ViewModel {
  final BuildContext context;
  final Store<AppState> store;

  _ViewModel({
    required this.context,
    required this.store,
  });
}
