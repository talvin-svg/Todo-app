import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_new/screens/homepage.dart';

class UserManagement {
  storeNewUser(user, context) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('newUsers')
        .doc(firebaseUser?.uid)
        .set({'email': user.email, 'uid': user.uid})
        .then((value) => {
              Future.delayed(const Duration(seconds: 4)),
              Navigator.pushNamed(context, MyHomePage.id)
            })
        .catchError((e) {
          print(e);
        });
  }
}
