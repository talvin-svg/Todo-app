import 'package:redux/redux.dart';
import 'package:todo_new/loading/actions.dart';
import 'package:todo_new/loading/model.dart';
import 'package:todo_new/loading/state.dart';

final loadingReducer = combineReducers<LoadingState>([
  TypedReducer<LoadingState, StartLoadingAction>(_startLoading),
  TypedReducer<LoadingState, StopLoadingAction>(_stopLoading),
]);

LoadingState _startLoading(
    LoadingState loadingState, StartLoadingAction action) {
  return loadingState.copyWith(
    loading: loadingState.loading.copyWith({
      'loadingMap': {
        ...loadingState.loading.loadingMap,
        action.loadingKey: LoadingType.loading,
      }
    }),
  );
}

LoadingState _stopLoading(LoadingState loadingState, StopLoadingAction action) {
  return loadingState.copyWith(
    loading: loadingState.loading.copyWith({
      'loadingMap': {
        ...loadingState.loading.loadingMap,
        action.loadingKey: LoadingType.notLoading,
      }
    }),
  );
}
