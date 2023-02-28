import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserManagement {
  storeNewUser(user, context) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseUser?.uid)
        .set({'email': user.email, 'uid': user.uid});
  }
}
