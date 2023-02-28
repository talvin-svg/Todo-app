import 'package:flutter/material.dart';
import 'package:todo_new/components/app_text.dart';
import 'package:todo_new/components/constants.dart';

class CustomDismissedContainer extends StatelessWidget {
  const CustomDismissedContainer(
      {super.key,
      this.name,
      required this.color,
      required this.icon,
      required this.isDelete});
  final String? name;
  final Color color;
  final IconData icon;
  final bool isDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: Row(
        mainAxisAlignment:
            isDelete ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: AppText(
                text: name ?? 'DELETE',
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          Icon(icon),
          spaceHorizontal
        ],
      ),
    );
  }
}
