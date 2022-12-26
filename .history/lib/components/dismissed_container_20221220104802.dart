import 'package:flutter/material.dart';

class CustomDismissedContainer extends StatelessWidget {
  const CustomDismissedContainer(
      {super.key, this.name, required this.color, required this.icon});
  final String? name;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            name ?? 'DELETE',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          Icon(icon)
        ],
      ),
    );
  }
}
