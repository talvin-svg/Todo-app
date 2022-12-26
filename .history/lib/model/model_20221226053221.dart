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
}
