import 'package:flutter/material.dart';
import 'package:todo_new/components/app_text.dart';

class TodoManager extends StatefulWidget {
  const TodoManager({
    super.key,
    required this.color,
    required this.title,
    this.ontap,
    required this.icon,
    required this.text,
  });
  final Color color;
  final String title;
  final void Function()? ontap;
  final IconData icon;
  final String text;

  @override
  State<TodoManager> createState() => _TodoManagerState();
}

class _TodoManagerState extends State<TodoManager> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(10, 5),
                    spreadRadius: 5,
                    blurRadius: 10)
              ]),
          width: 200,
          height: 100,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        text: widget.title,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Icon(widget.icon)
                    ],
                  ),
                  AppText(
                    text: widget.text,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
