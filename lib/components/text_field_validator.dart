import 'package:flutter/material.dart';

bool isLoginFieldsValid(
  String email,
  String password,
) {
  if (email.trim().isEmpty || password.trim().isEmpty) return false;
  return true;
}

bool isSignUpFieldsValid(
    TextEditingController email, TextEditingController password) {
  if (email.text.trim().isEmpty || password.text.trim().isEmpty) return false;
  return true;
}
