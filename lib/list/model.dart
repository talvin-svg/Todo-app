class Item {
  String? title;
  String? id;
  bool done = false;
  DateTime createdAt = DateTime.now();

  Item({
    required this.title,
    this.id,
    bool? done,
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

  Item copyWith({
    String? title,
    String? id,
    bool? done,
  }) {
    return Item(
      title: title ?? this.title,
      id: id ?? this.id,
      done: done ?? this.done,
    );
  }
}
