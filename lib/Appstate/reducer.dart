import 'package:todo_new/Appstate/appstate.dart';

import 'package:todo_new/list/reducer.dart';
import 'package:todo_new/list/state.dart';

AppState appStateReducer(AppState oldState, action) => AppState(
    itemListState: itemsReducer(oldState.itemListState, action),
    filter: itemFilterReducer(oldState, action));

ItemFilter itemFilterReducer(AppState state, action) {
  if (action is ChangeFilterAction) {
    return action.filter;
  } else {
    return state.filter;
  }
}

class ChangeFilterAction {
  final ItemFilter filter;
  const ChangeFilterAction(this.filter);
}