import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/scaffold_error_message.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

Future createUser({
  required String email,
  required String password,
  required BuildContext context,
}) async {
  await firebaseAuth
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((value) {
    previewSuccess(
        message: ' ${value.user!.uid} account succesfully created!',
        context: context);
  });
}
