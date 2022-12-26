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
      width: 300,
      height: 100,
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.red, width: 5.0),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: todoName,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  AppText(text: time),
                  GestureDetector(
                    onTap: ontapIcon,
                    child: Icon(icon),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
