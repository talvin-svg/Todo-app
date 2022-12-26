import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_new/components/app_text.dart';

class TodoManager extends StatelessWidget {
  const TodoManager(
      {super.key,
      required this.color,
      required this.title,
      this.shadow,
      this.ontap,
      required this.icon});
  final Color color;
  final Color? shadow;
  final String title;
  final void Function()? ontap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: color,
        shadowColor: shadow,
        child: AppText(
          text: title,
          fontSize: 25,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
