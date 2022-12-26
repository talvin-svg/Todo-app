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

  final String title;
  final void Function()? ontap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 300,
        height: 200,
        color: color,
        child: AppText(
          text: title,
          fontSize: 25,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
