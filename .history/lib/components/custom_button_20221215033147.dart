import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function ontap;
  final Color? color;
  const CustomButton(
      {super.key,
      required this.title,
      required this.ontap,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap(),
      child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          width: 50,
          height: 50,
          child: Center(child: Text(title))),
    );
  }
}
