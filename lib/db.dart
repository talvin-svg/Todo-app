import 'package:firebase_auth/firebase_auth.dart';

// ignore: non_constant_identifier_names
String get FIR_UID => FirebaseAuth.instance.currentUser?.uid ?? '';
