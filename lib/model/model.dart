import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Item {
  String? title;
  String? id;
  bool done = false;
  DateTime createdAt = DateTime.now();

  Item({
    required this.title,
    this.id,
  });

  factory Item.fromMap(Map<String, dynamic>? data) {
    return Item(
      title: data?['title'],
      id: data?['id'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'done': false,
      'createdAt': DateTime.now(),
      'id': id
    };
  }

  // factory Item.fromSnapshot(DocumentSnapshot? snapshot) {
  //   Map<String, dynamic> data = snapshot?.data() as Map<String, dynamic>;
  //   return Item(title: data['title'] as String);
  // }
}
