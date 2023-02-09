import 'package:flutter/material.dart';
import 'package:todo_new/list/constants.dart';

enum LoadingType {
  loading,
  notLoading,
}

@immutable
class Loading {
  final Map<String?, LoadingType> loadingMap;

  const Loading(this.loadingMap);

  Loading copyWith(Map<String?, dynamic> changeParameters) {
    return Loading(changeParameters['loadingMap'] ?? loadingMap);
  }

  LoadingType? getLoadingState(String? loadingKey) {
    if (loadingKey == fetchTodoLoadingKey ||
        loadingKey == updateTodoLoadingKey ||
        loadingKey == removeTodoLoadingKey) {
      return loadingMap[loadingKey] ?? LoadingType.loading;
    }
    return loadingMap[loadingKey];
  }
}
