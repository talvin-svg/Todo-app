import 'package:flutter/material.dart';
import '../components/constants.dart';
import '../components/app_text.dart';

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
                spaceVertical,
                const AppText(text: 'The right app to Track progress!'),
                spaceHorizontal
              ],
            ),
          ),
        ));
  }
}
