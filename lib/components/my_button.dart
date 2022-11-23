import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {Key? key, required this.name, required this.color, required this.ontap})
      : super(key: key);

  final String name;
  final Color color;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Center(child: Text(name)),
      ),
    );
  }
}
