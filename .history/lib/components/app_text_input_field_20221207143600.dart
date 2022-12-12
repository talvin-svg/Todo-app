import 'package:flutter/material.dart';
import 'apptextfield.dart';

class AppRichTextInputField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final int? maxLines;
  final Icon? suffixIcon;
  final void Function()? suffixFunction;
  final Color? color;
  final Color? hintColor;

  AppRichTextInputField(
    BuildContext context, {
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.maxLines,
    this.suffixFunction,
    this.suffixIcon,
    this.color,
    this.hintColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppTextField(
          padding: const EdgeInsets.all(10),
          controller: controller,
          hintText: hintText,
          fontSize: 14,
          obscureText: obscureText,
          maxLines: maxLines,
          suffixFunction: suffixFunction,
          suffixIcon: suffixIcon,
          color: color,
          hintColor: hintColor,
        ),
      ),
    );
  }
}
