import 'dart:core';
import 'package:flutter/material.dart';
import 'package:todo_new/actions/item_filter.dart';
import 'package:todo_new/loading/state.dart';
import 'package:todo_new/model/model.dart';

@immutable
class AppState {
  const AppState(
      {this.loadingState = const LoadingState(),
      this.itemListState = const [],
      this.filter = ItemFilter.all});

  final List<Item> itemListState;
  final ItemFilter filter;
  final LoadingState loadingState;

  factory AppState.initial() => const AppState();

  AppState copyWith(itemListState) {
    return AppState(itemListState: itemListState ?? this.itemListState);
  }

  factory AppState.fromMap(Map<String, dynamic>? data) {
    if (data == null) return AppState.initial();

    List<Item> itemListState = <Item>[];
    if (data['todos'] != null) {
      data['todos'].forEach((todoData) {
        itemListState.add(Item.fromMap(todoData));
      });
    }
    return AppState(itemListState: itemListState);
  }

  List<Item> get filteredItems {
    switch (filter) {
      case ItemFilter.all:
        return itemListState;
      case ItemFilter.done:
        return itemListState.where((e) => e.done == true).toList();
    }
  }

  int get completed {
    return itemListState.where((e) => e.done == true).toList().length;
  }

  int get notCompleted {
    return itemListState.where((e) => e.done == false).toList().length;
  }
}
