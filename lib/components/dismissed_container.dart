import 'package:flutter/material.dart';

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
      color: color,
      child: Row(
        mainAxisAlignment:
            isDelete ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name ?? 'DELETE',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10),
          Icon(icon)
        ],
      ),
    );
  }
}
