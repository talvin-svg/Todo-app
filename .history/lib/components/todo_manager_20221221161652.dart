import 'package:flutter/material.dart';
import 'package:todo_new/components/app_text.dart';

class TodoManager extends StatelessWidget {
  const TodoManager(
      {super.key,
      required this.color,
      required this.title,
      this.ontap,
      required this.icon});
  final Color color;
  static const int completedCounter = 0;
  final String title;
  final void Function()? ontap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10)),
          width: 300,
          height: 100,
          child: Center(
            child: AppText(
              text: title,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
