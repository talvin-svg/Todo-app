import 'package:flutter/material.dart';
import 'package:todo_new/components/app_text.dart';

class TodoManager extends StatefulWidget {
  const TodoManager({
    super.key,
    required this.color,
    required this.title,
    this.ontap,
    required this.isCompleted,
    required this.icon,
  });
  final Color color;

  static const int completedCounter = 0;
  final String title;
  final void Function()? ontap;
  final IconData icon;
  final bool isCompleted;

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
              color: widget.color, borderRadius: BorderRadius.circular(10)),
          width: 300,
          height: 100,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      AppText(
                        text: widget.title,
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                      Icon(widget.icon)
                    ],
                  ),
                  const AppText(
                    text: '${TodoManager.completedCounter}',
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
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
