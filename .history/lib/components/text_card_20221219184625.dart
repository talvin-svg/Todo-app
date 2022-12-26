import 'package:flutter/material.dart';
import 'package:todo_new/components/app_text.dart';

class TextCard extends StatelessWidget {
  const TextCard(
      {Key? key,
      required this.name,
      required this.icon,
      required this.ontapIcon})
      : super(key: key);

  final String todo;

  final IconData icon;
  final VoidCallback ontapIcon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Expanded(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black45),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  AppText(
                    text: todo,
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                  GestureDetector(
                    onTap: ontapIcon,
                    child: Icon(icon),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
