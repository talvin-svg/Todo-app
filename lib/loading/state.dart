class LoadingState {
  final Map<String, bool> loadingState;

  LoadingState({this.loadingState = const {}});

  LoadingState copyWith({Map<String, bool>? loadingState}) {
    return LoadingState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
