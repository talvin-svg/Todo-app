import 'dart:core';
import 'package:flutter/material.dart';
import 'package:todo_new/list/state.dart';
import 'package:todo_new/loading/state.dart';

@immutable
class AppState {
  const AppState({
    this.loadingState = const LoadingState(),
    this.itemListState = const ItemListState(),
  });

  final ItemListState itemListState;

  final LoadingState loadingState;

  factory AppState.initial() => const AppState();
}
