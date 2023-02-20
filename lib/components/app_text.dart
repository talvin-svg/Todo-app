import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });
  final String? text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines ?? 1,
      // ignore: unnecessary_null_in_if_null_operators
      overflow: overflow ?? null,
      style: GoogleFonts.poppins(
          fontSize: fontSize ?? 13,
          height: 1.5,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: color ?? Colors.black),
    );
  }
}
