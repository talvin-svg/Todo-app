import 'package:todo_new/loading/model.dart';

class LoadingState {
  final Loading loading;

  const LoadingState({this.loading = const Loading({})});

  LoadingState copyWith({Loading? loading}) {
    return LoadingState(
      loading: loading ?? this.loading,
    );
  }
}
