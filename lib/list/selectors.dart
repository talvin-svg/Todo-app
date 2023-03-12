import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:todo_new/Appstate/appstate.dart';
import 'package:todo_new/list/model.dart';
import 'package:intl/intl.dart';

List<Item> selectItemsByDay(String day, Store<AppState> store) {
  List<Item> items = store.state.filteredItems;
  return items
      .where((item) =>
          DateFormat('EE').format(item.dueDate ?? DateTime.now()) == day)
      .toList();
}

List<Item> selectItemsByCategories(Categories category, Store<AppState> store) {
  List<Item> items = store.state.filteredItems;

  return items
      .where((item) => categorySelector(item.category!) == category)
      .toList();
}

String categoryStringSelector(Categories category) {
  final categoryMap = {
    Categories.work: 'Work',
    Categories.personal: 'Personal',
    Categories.urgent: 'Urgent',
  };
  return categoryMap[category] ?? 'Unknown';
}

Categories categorySelector(String category) {
  final categoryMap = {
    'Work': Categories.work,
    'Personal': Categories.personal,
    'Urgent': Categories.urgent,
  };
  return categoryMap[category] ?? Categories.work;
}

Icon iconStringSelector(String category) {
  final iconMap = {
    "Work": const Icon(Icons.work),
    "Personal": const Icon(Icons.book),
    "Urgent": const Icon(Icons.priority_high),
  };
  return iconMap[category] ?? const Icon(Icons.help_outline);
}

Icon iconCategorySelector(Categories category) {
  final categoryMap = {
    Categories.work: const Icon(Icons.work),
    Categories.personal: const Icon(Icons.book),
    Categories.urgent: const Icon(Icons.priority_high),
  };
  return categoryMap[category] ?? const Icon(Icons.help_outline);
}

String colorSelector(Color color) {
  final colorMap = {
    Colors.indigo.shade100: 'indigo',
    Colors.orange.shade300: 'orange',
    Colors.purple: 'purple',
    Colors.pink: 'pink',
  };
  return colorMap[color] ?? 'unknown';
}

Color getBackColor(String colorString) {
  final colorMap = {
    'indigo': Colors.indigo.shade100,
    'orange': Colors.orange.shade300,
    'purple': Colors.purple,
    'pink': Colors.pink
  };
  return colorMap[colorString] ?? Colors.indigo.shade100;
}
