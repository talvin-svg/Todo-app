class StartLoadingAction {
  final String? loadingKey;

  StartLoadingAction({required this.loadingKey});

  @override
  String toString() {
    return 'Start loading state for $loadingKey ';
  }
}

class StopLoadingAction {
  final String? loadingKey;

  StopLoadingAction({required this.loadingKey});

  @override
  String toString() {
    return 'Stop loading state for $loadingKey';
  }
}
