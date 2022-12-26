import 'package:flutter/material.dart';
import 'package:todo_new/components/app_text.dart';

class TextCard extends StatelessWidget {
  TextCard(
      {Key? key,
      required this.todoName,
      required this.icon,
      required this.ontapIcon,
      this.time})
      : super(key: key);

  final String todoName;
  late String? time;
  final IconData icon;
  final VoidCallback ontapIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45, width: 5),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: todoName,
                fontSize: 20,
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
