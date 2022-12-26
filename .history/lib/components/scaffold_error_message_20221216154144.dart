import 'package:flutter/material.dart';

import 'app_text.dart';

void previewError({required String message, required BuildContext context}) {
  final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        color: Colors.red,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: AppText(
            text: message,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void previewSuccess({required String message, required BuildContext context}) {
  final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: AppText(
            text: message,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
