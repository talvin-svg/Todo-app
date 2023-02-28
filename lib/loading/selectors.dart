import 'package:todo_new/Appstate/appstate.dart';
import 'package:todo_new/loading/model.dart';

LoadingType? getLoadingState(AppState state, String? loadingKey) =>
    state.loadingState.loading.getLoadingState(
      loadingKey,
    );

bool selectIsLoading(AppState state, String? loadingKey) {
  bool isLoading = state.loadingState.loading.getLoadingState(loadingKey) ==
      LoadingType.loading;
  return isLoading;
}
