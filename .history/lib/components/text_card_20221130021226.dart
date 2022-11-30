import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {
  const TextCard({Key? key, required this.name, required this.ontap})
      : super(key: key);

  final String name;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      )),
    );
  }
}
