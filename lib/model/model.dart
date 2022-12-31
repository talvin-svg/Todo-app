import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String? title;
  bool done = false;
  DateTime createdAt = DateTime.now();

  Item({required this.title});

  factory Item.fromMap(Map<String, dynamic>? data) {
    return Item(
      title: data!['title'],
    );
  }
  @override
  Map<String, dynamic> toMap() {
    return {'title': title, 'done': false, 'createdAt': DateTime.now()};
  }

  factory Item.fromSnapshot(DocumentSnapshot? snapshot) {
    Map<String, dynamic> data = snapshot?.data() as Map<String, dynamic>;
    return Item(title: data['title'] as String);
  }
}
