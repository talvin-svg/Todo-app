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

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

Future<void> signOut() async {
  try {
    await firebaseAuth.signOut();
  } catch (e) {
    print(e);
  }
}
