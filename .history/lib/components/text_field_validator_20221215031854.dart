import 'package:flutter/material.dart';

bool isLoginFieldsValid(
    TextEditingController email, TextEditingController password) {
  if (email.text.trim().isEmpty || password.text.trim().isEmpty) return false;
  return true;
}

bool isSignUpFieldsValid(TextEditingController name,
    TextEditingController email, TextEditingController password) {
  if (name.text.trim().isEmpty ||
      email.text.trim().isEmpty ||
      password.text.trim().isEmpty) return false;
  return true;
}
