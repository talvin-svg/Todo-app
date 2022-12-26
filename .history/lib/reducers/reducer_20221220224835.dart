import '/Appstate/appstate.dart';
import '/actions/actions.dart';
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

// AppState toogleItemSelectionReducer(
//     AppState state, ToggleItemSelection action) {
//   !state.itemListState.elementAt(action.index).done;
//   return state.copyWith(state.itemListState);
// }

AppState toggleItemSelectionReducer(
    AppState state, ToggleItemSelection action) {
  // Create a copy of the list
  Item modifiedItem = state.itemListState
      .elementAt(action.index); // Retrieve the element at the specified index
  modifiedItem.done = !modifiedItem.done; // Toggle the done property
  state.itemListState.replaceRange(action.index, action.index + 1, [
    modifiedItem
  ]); // Replace the element in the list with the modified element
  return state.copyWith(state
      .itemListState); // Return a copy of the current state with the updated list of items
}

AppState addItemReducer(AppState state, AddItemAction action) {
  return state.copyWith([...state.itemListState, action.item]);
}

AppState removeItemReducer(AppState state, RemoveAction action) {
  state.itemListState.removeAt(action.index);
  return state.copyWith(state.itemListState);
}

AppState editItemReducer(AppState state, EditItemAction action) {
  Item modifiedItem = state.itemListState.elementAt(action.index);
  modifiedItem.title = action.name;
  if (modifiedItem.done == true) {
    modifiedItem.done = false;
  }
  state.itemListState
      .replaceRange(action.index, action.index + 1, [modifiedItem]);
  return state.copyWith(state.itemListState);
}

final itemReducer = combineReducers<AppState>([
  TypedReducer<AppState, AddItemAction>(addItemReducer),
  TypedReducer<AppState, RemoveAction>(removeItemReducer),
  TypedReducer<AppState, ToggleItemSelection>(toggleItemSelectionReducer),
  TypedReducer<AppState, EditItemAction>(editItemReducer),
]);
