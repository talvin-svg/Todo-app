import 'package:flutter/material.dart';
import 'package:todo_new/components/app_text.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});
  static const String id = 'intro';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: const CircleAvatar(),
          actions: [
            Column(
              children: const [
                CircleAvatar(
                  child: Icon(Icons.notifications),
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            const CircleAvatar(
              child: Icon(Icons.add),
            )
          ]),
      body: Column(
        children: [
          AppText(
            text: "Good Morning ",
            color: Theme.of(context).colorScheme.primary,
            fontSize: 40,
          )
        ],
      ),
    );
  }
}
