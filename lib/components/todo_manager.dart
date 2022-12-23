import 'package:flutter/material.dart';
import 'package:todo_new/components/app_text.dart';

class TodoManager extends StatefulWidget {
  TodoManager({
    super.key,
    required this.color,
    required this.title,
    this.ontap,
    required this.isCompleted,
    required this.icon,
  });
  final Color color;

  static int completedCounter = 0;
  final String title;
  final void Function()? ontap;
  final IconData icon;
  final bool isCompleted;

  static set completedCounterCheck(int value) => completedCounter = value;

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        text: widget.title,
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Icon(widget.icon)
                    ],
                  ),
                  AppText(
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
