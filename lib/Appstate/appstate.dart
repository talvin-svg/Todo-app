import 'package:flutter/material.dart';

import '../model/model.dart';

class AppState {
  // List itemListState = <Item>[];
  final List<dynamic> itemListState;

  const AppState({this.itemListState = const []});

  factory AppState.initial() => const AppState();

  AppState copyWith(itemListState) {
    return AppState(itemListState: itemListState ?? this.itemListState);
  }

  factory AppState.fromMap(Map<String, dynamic>? data) {
    if (data == null) return AppState.initial();

    List<dynamic> itemListState = <dynamic>[];
    if (data['todos'] != null) {
      data['todos'].forEach((todoData) {
        itemListState.add(Item.fromMap(todoData));
      });
    }
    return AppState(itemListState: itemListState);
  }
}
