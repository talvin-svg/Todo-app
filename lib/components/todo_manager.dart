import 'package:flutter/material.dart';
import 'package:todo_new/components/app_text.dart';
import 'package:intl/intl.dart';
import 'package:todo_new/components/constants.dart';

class TodoManager extends StatefulWidget {
  const TodoManager(
      {super.key,
      required this.color,
      required this.title,
      this.onclick,
      this.ontap,
      this.completed,
      this.iconMore,
      required this.categoryIcon,
      required this.details,
      required this.dueDate});
  final Color color;
  final String title;
  final void Function()? ontap;
  final void Function()? onclick;
  final Icon? iconMore;
  final Icon categoryIcon;
  final String? details;
  final String dueDate;
  final String? completed;

  @override
  State<TodoManager> createState() => _TodoManagerState();
}

class _TodoManagerState extends State<TodoManager> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: widget.onclick,
        child: Container(
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(30),
          ),
          width: MediaQuery.of(context).size.width - 15,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    widget.categoryIcon,
                    const SizedBox(
                      width: 10.0,
                    ),
                    AppText(
                      color: Theme.of(context).colorScheme.onBackground,
                      text: widget.title,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Expanded(child: Container()),
                    AppText(
                      text: DateFormat('MMM dd, hh:mm')
                          .format(DateTime.parse(widget.dueDate))
                          .toString(),
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    spaceHorizontal,
                    GestureDetector(onTap: widget.ontap, child: widget.iconMore)
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 35.0,
                    ),
                    AppText(
                      text: widget.details,
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    Expanded(child: Container()),
                    AppText(
                      text: widget.completed,
                      color: const Color.fromARGB(255, 12, 232, 23),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
