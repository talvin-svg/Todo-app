import 'package:flutter/material.dart';
import '/components/custom_button.dart';
import '/screens/signup.dart';
import '../components/app_text.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth fauth = FirebaseAuth.instance;

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static const String id = 'welcome';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.light(),
        home: Scaffold(
          // backgroundColor: Theme.of(context).backgroundColor,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/todo-logo.png'),
                const SizedBox(
                  height: 15,
                ),
                const AppText(text: 'The right app to Track progress!'),
                const SizedBox(
                  height: 15,
                ),
                CustomButton(
                    title: 'Get Started',
                    ontap: () {
                      Navigator.pushNamed(context, SignUpPage.id);
                    },
                    color: Colors.blue)
              ],
            ),
          ),
        ));
  }
}
