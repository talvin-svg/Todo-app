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

  return items.where((item) => item.category == category).toList();
}

String categorySeletor(Categories category) {
  String? result;
  switch (category) {
    case Categories.work:
      result = 'Work';
      break;

    case Categories.personal:
      result = 'Personal';
      break;
    case Categories.urgent:
      result = 'Urgent';
      break;
  }
  return result;
}

Icon iconSelector(Categories category) {
  Icon? result;

  switch (category) {
    case Categories.work:
      result = const Icon(Icons.work);
      break;

    case Categories.personal:
      result = const Icon(Icons.book);
      break;
    case Categories.urgent:
      result = const Icon(Icons.priority_high);
      break;
  }
  return result;
}
