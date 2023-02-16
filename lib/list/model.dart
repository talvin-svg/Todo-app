import 'dart:ui';

class Item {
  String? title;
  String? id;
  bool done = false;
  DateTime createdAt = DateTime.now();
  Color? color;

  Item({required this.title, this.id, bool? done, required this.color});

  factory Item.fromMap(Map<String, dynamic>? data) {
    return Item(title: data?['title'], id: data?['id'], color: data?['color']);
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'done': false,
      'createdAt': DateTime.now(),
      'id': id
    };
  }

  Item copyWith({
    String? title,
    String? id,
    bool? done,
  }) {
    return Item(
        title: title ?? this.title,
        id: id ?? this.id,
        done: done ?? this.done,
        color: color ?? this.color);
  }
}
