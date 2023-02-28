import 'package:flutter/material.dart';
import 'package:todo_new/list/model.dart';
import 'package:todo_new/list/state.dart';
import 'package:todo_new/loading/state.dart';

@immutable
class AppState {
  const AppState(
      {this.loadingState = const LoadingState(),
      this.itemListState = const ItemListState(),
      this.filter = ItemFilter.all});

  final ItemListState itemListState;
  final LoadingState loadingState;
  final ItemFilter filter;

  factory AppState.initial() => const AppState();

  List<Item> get filteredItems {
    switch (filter) {
      case ItemFilter.all:
        return itemListState.itemList;
      case ItemFilter.done:
        return itemListState.itemList.where((e) => e.done == true).toList();
      case ItemFilter.active:
        return itemListState.itemList.where((e) => e.done == false).toList();
    }
  }
}
