import 'dart:ui';

class Item {
  String? title;
  String? id;
  bool? done;

  String? color;
  String? details;
  DateTime? dueDate;
  String? category;

  Item(
      {required this.title,
      required this.details,
      required this.category,
      required this.id,
      this.done = false,
      this.color,
      this.dueDate});

  factory Item.fromMap(Map<String, dynamic>? data) {
    return Item(
        dueDate: data?['dueDate'].toDate(),
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
      'id': id,
      'details': details,
      'dueDate': dueDate,
      'color': color,
      'category': category
    };
  }

  Item copyWith(
      {String? title,
      String? id,
      bool? done,
      String? color,
      String? details,
      String? category,
      DateTime? dueDate}) {
    return Item(
        category: category ?? this.category,
        dueDate: dueDate ?? this.dueDate,
        title: title ?? this.title,
        id: id ?? this.id,
        done: done ?? this.done,
        color: color ?? this.color,
        details: details ?? this.details);
  }
}

enum Categories { urgent, personal, work }
