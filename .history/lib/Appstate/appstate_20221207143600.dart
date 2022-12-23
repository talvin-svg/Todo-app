import 'package:flutter/material.dart';

import '../model/model.dart';

class AppState {
  List itemListState = <Item>[];

  AppState({required this.itemListState});

  AppState copyWith(itemListState) {
    return AppState(itemListState: itemListState ?? this.itemListState);
  }
}
