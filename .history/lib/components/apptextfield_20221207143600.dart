import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? autoFocus;
  final TextInputAction? textInputAction;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final String? hintText;
  final InputBorder? border;
  final bool? obscureText;
  final EdgeInsets? padding;
  final Color? hintColor;
  final TextAlign? textAlign;
  final bool? enabled;
  final Function()? onTap;
  final Icon? suffixIcon;
  final void Function()? suffixFunction;

  const AppTextField(
      {super.key,
      required this.controller,
      this.autoFocus,
      this.textInputAction,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.hintText,
      this.border,
      this.obscureText,
      this.padding,
      this.hintColor,
      this.textAlign,
      this.enabled,
      this.onTap,
      this.suffixIcon,
      this.suffixFunction,
      int? maxLines});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: padding ?? EdgeInsets.zero,
        hintText: hintText ?? '',
        border: border ?? InputBorder.none,
        suffix: suffixFunction != null && suffixIcon != null
            ? IconButton(onPressed: suffixFunction, icon: suffixIcon!)
            : null,
        hintStyle: TextStyle(
          fontSize: fontSize ?? 18,
          fontWeight: fontWeight ?? FontWeight.w300,
          color: hintColor ?? Colors.black,
        ),
      ),
      enabled: enabled ?? true,
      textAlign: textAlign ?? TextAlign.center,
      autofocus: autoFocus ?? false,
      controller: controller,
      textInputAction: textInputAction ?? TextInputAction.done,
      onTap: onTap,
      obscureText: obscureText ?? false,
      style: TextStyle(
        color: color ?? Colors.blueGrey.withOpacity(0.5),
        fontSize: fontSize ?? 18,
        fontWeight: fontWeight ?? FontWeight.w300,
      ),
    );
  }
}
