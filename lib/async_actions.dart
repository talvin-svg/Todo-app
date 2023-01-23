// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:todo_new/screens/welcome_screen.dart';
// import '../components/scaffold_error_message.dart';

// FirebaseAuth firebaseAuth = FirebaseAuth.instance;
// class Firestore{
//   Future createUser({
//   required String email,
//   required String password,
//   required BuildContext context,
// }) async {
//   await firebaseAuth
//       .createUserWithEmailAndPassword(email: email, password: password)
//       .then((value) {
//     previewSuccess(
//         message: ' ${value.user!.uid} account succesfully created!',
//         context: context);
//   });
// }

// void Signout() async {
//   await firebaseAuth.signOut();
// }

// Future signOut({BuildContext? context}) async {
//   await firebaseAuth.signOut().then((value) {
//     if (context != null) Navigator.pushNamed(context,  WelcomeScreen.id);
//     return;
//   });
// }

//  static Future deleteDocument({
//     required String collectionPath,
//     required String docPath,
//     required String loadingKey,

//     Function? onSuccess,
//   }) async {

//     try {
//       await db.collection(collectionPath).doc(docPath).delete();
//       if (onSuccess != null) onSuccess();
//     } on FirebaseException catch (e) {
//       print(e);
//       return null;
//     } on Exception catch (e) {
//       print(e);
//       return null;
//     }

//   }

// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_new/screens/homepage_revamped.dart';

import 'components/scaffold_error_message.dart';
import 'components/text_field_validator.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

Future<void> signOut() async {
  try {
    await firebaseAuth.signOut();
  } catch (e) {
    print(e);
  }
}

Future signIn(String email, String password, BuildContext context) async {
  bool onSuccess = false;
  if (!isLoginFieldsValid(
    email,
    password,
  )) {
    previewError(context: context, message: 'Fields not filled in correctly!');
    return;
  }
  await signOut();
  try {
    var result = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    String user = result.user!.uid;
    onSuccess = true;
    previewSuccess(
        message: 'Welcome Back!, Lets get to work', context: context);

    Future.delayed(const Duration(seconds: 4), (() {
      (onSuccess)
          ? Navigator.pushNamed(context, HompePageToo.id)
          : previewError(
              message: 'Account could not be created at this time',
              context: context);
    }));
    return;
  } catch (e) {
    print(e.toString());
    return;
  }
}
