import 'dart:ui';

class Item {
  String? title;
  String? id;
  bool done = false;
  DateTime? createdAt;
  Color? color;
  String? details;

  Item(
      {required this.title,
      this.id,
      bool? done,
      required this.color,
      required details});

  factory Item.fromMap(Map<String, dynamic>? data) {
    return Item(
        title: data?['title'],
        id: data?['id'],
        color: data?['color'],
        done: data?['done'],
        details: data?['details']);
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'done': false,
      'createdAt': '',
      'id': id,
      'details': details
    };
  }

  Item copyWith(
      {String? title, String? id, bool? done, Color? color, String? details}) {
    return Item(
        title: title ?? this.title,
        id: id ?? this.id,
        done: done ?? this.done,
        color: color ?? this.color,
        details: details ?? this.details);
  }
}
