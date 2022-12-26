class Item {
  String? title;
  bool done = false;
  int createdAt = DateTime.now().day;

  Item({required this.title});
}
