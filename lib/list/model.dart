import 'dart:ui';

class Item {
  String? title;
  String? id;
  bool done = false;
  DateTime createdAt;
  String? color;
  String? details;
  DateTime? dueDate;
  Categories? category;

  Item(
      {required this.title,
      required this.details,
      required this.createdAt,
      required this.category,
      required this.id,
      bool? done,
      this.color,
      this.dueDate});

  factory Item.fromMap(Map<String, dynamic>? data) {
    return Item(
        dueDate: data?['dueDate'],
        createdAt: data?['createdAt'],
        title: data?['title'],
        id: data?['id'],
        color: data?['color'],
        done: data?['done'],
        category: data?['category'],
        details: data?['details']);
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'done': done,
      'createdAt': '',
      'id': id,
      'details': details,
      'dueDate': dueDate,
      'color': color
    };
  }

  Item copyWith(
      {String? title,
      String? id,
      bool? done,
      String? color,
      String? details,
      Categories? category,
      DateTime? createdAt,
      DateTime? dueDate}) {
    return Item(
        category: category ?? this.category,
        createdAt: createdAt ?? this.createdAt,
        dueDate: dueDate ?? this.dueDate,
        title: title ?? this.title,
        id: id ?? this.id,
        done: done ?? this.done,
        color: color ?? this.color,
        details: details ?? this.details);
  }
}

enum Categories { urgent, personal, work }
