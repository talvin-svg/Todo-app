import 'package:flutter/material.dart';
import 'package:todo_new/components/app_text.dart';

enum TodoType { urgent, important, regular }

class TextCard extends StatelessWidget {
  const TextCard({
    Key? key,
    required this.todoName,
    required this.icon,
    required this.ontapIcon,
    this.time,
    required this.iconSecondary,
    required this.ontapIconSecondary,
    required this.color,
  }) : super(key: key);

  final String? todoName;
  final String? time;
  final IconData icon;
  final VoidCallback ontapIcon;
  final IconData iconSecondary;
  final VoidCallback ontapIconSecondary;
  final Color color;
  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width: 400,
      height: 100,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: color, width: 5.0),
          // right: BorderSide(color: Colors.red, width: 5.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: AppText(
                    text: todoName,
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
                // const SizedBox(width: 200),
                GestureDetector(
                  onTap: ontapIcon,
                  child: Icon(icon),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: time,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
                // const SizedBox(width: 200),
                GestureDetector(
                  onTap: ontapIconSecondary,
                  child: Icon(iconSecondary),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
