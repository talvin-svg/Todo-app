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
      child: Center(
        child: Row(
          children: [Text(name ?? ''), const SizedBox(width: 10), Icon(icon)],
        ),
      ),
    );
  }
}
