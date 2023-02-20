import 'package:flutter/material.dart';
import 'package:todo_new/components/app_text.dart';
import 'package:intl/intl.dart';

class TodoManager extends StatefulWidget {
  const TodoManager(
      {super.key,
      required this.color,
      required this.title,
      this.ontap,
      required this.icon,
      required this.details,
      required this.dueDate});
  final Color color;
  final String title;
  final void Function()? ontap;
  final Icon icon;
  final String details;
  final String dueDate;
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
            borderRadius: BorderRadius.circular(30),
          ),
          width: MediaQuery.of(context).size.width - 15,
          height: 130,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AppText(
                          text: widget.title,
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(child: Container()),
                      AppText(
                        text: DateFormat('MMM dd, hh:mm')
                            .format(DateTime.parse(widget.dueDate))
                            .toString(),
                        color: Colors.black,
                      ),
                      GestureDetector(onTap: widget.ontap, child: widget.icon)
                    ],
                  ),
                  AppText(
                    text: widget.details,
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
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
