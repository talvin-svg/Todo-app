import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo_new/components/constants.dart';
import 'package:todo_new/components/scaffold_error_message.dart';
import '../components/custom_button.dart';
import '../components/text_field_validator.dart';
import '/components/app_text_input_field.dart';
import '../components/app_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool showPassword = true;
  bool loading = false;
  bool onSuccess = false;
  late UserCredential result;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void makeUser() {
    setState(() {
      loading = true;
    });
    signUpUser(_emailController.text, _passwordController.text);

    Future.delayed(const Duration(seconds: 4), (() {
      (onSuccess)
          ? Navigator.pushNamed(context, homey)
          : previewError(
              message: 'Account could not be created at this time',
              context: context);
      setState(() {
        loading = false;
      });
    }));
    setState(() {
      loading = false;
    });
  }

  void signUpUser(String email, String password) async {
    if (!isSignUpFieldsValid(_emailController, _passwordController)) {
      previewError(
          context: context, message: 'Fields not filled in correctly!');
      return;
    }
    try {
      result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      String user = result.user!.uid;
      setState(() {
        onSuccess = true;
      });
      previewSuccess(message: 'Account Succesfully created', context: context);

      return;
    } catch (e) {
      print(e.toString());
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        appBar: AppBar(
          leading: CustomButton(
            color: Colors.teal,
            title: 'back',
            ontap: () => Navigator.pop(context),
          ),
        ),
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
                      text:
                          'Sign up to start using todo app and get work done!'),
                  const SizedBox(
                    height: 20,
                  ),
                  AppRichTextInputField(
                    context,
                    hintText: 'Email',
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
                      ontap: () {
                        makeUser();
                      },
                      color: Colors.blue),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const AppText(text: "do you already have an account?"),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          child: const AppText(
                            text: 'Login',
                            fontSize: 20,
                          ),
                          onTap: () => Navigator.pushNamed(context, signIner),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
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
