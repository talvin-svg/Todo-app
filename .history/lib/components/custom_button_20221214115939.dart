import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function() ontap;
  final Color? color;
  const CustomButton(
      {super.key,
      required this.title,
      required this.ontap,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child:
          Container(width: 100, height: 100, color: color, child: Text(title)),
    );
  }
}
