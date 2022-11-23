import 'package:newwer_todo/Appstate/appstate.dart';
import 'package:newwer_todo/actions/actions.dart';
import 'package:redux/redux.dart';

import '../model/model.dart';

// AppState reducer(AppState state, dynamic action) {
//   if (action is AddItemAction) {
//     print('add item action');

//     // var itemListState = <Item>[];
//     return state.copyWith([...state.itemListState, action.item]);
//   } else if (action is RemoveAction) {
//     print('remove item');
//     state.itemListState.removeAt(action.index);
//     return state.copyWith(state.itemListState);
//   }
//   return state;
// }

AppState addItemReducer(AppState state, AddItemAction action) {
  return state.copyWith([...state.itemListState, action.item]);
}

AppState removeItemReducer(AppState state, RemoveAction action) {
  state.itemListState.removeAt(action.index);
  return state.copyWith(state.itemListState);
}

final itemReducer = combineReducers<AppState>([
  TypedReducer<AppState, AddItemAction>(addItemReducer),
  TypedReducer<AppState, RemoveAction>(removeItemReducer),
]);
