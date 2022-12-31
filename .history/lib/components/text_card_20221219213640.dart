import 'package:flutter/material.dart';
import 'package:todo_new/components/app_text.dart';

class TextCard extends StatelessWidget {
  const TextCard(
      {Key? key,
      required this.todoName,
      required this.icon,
      required this.ontapIcon,
      this.time})
      : super(key: key);

  final String todoName;
  final String? time;
  final IconData icon;
  final VoidCallback ontapIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: todoName,
                fontSize: 15,
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
    );
  }
}