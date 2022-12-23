import 'package:flutter/material.dart';
import 'package:newwer_todo/components/custom_button.dart';
import 'package:newwer_todo/screens/signup.dart';
import '../components/app_text.dart';
import '../components/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
                    title: 'SignUp',
                    ontap: () => Navigator.pushNamed(context, 'SignUpPage'),
                    color: Colors.blue)
              ],
            ),
          ),
        ));
  }
}
