import 'package:flutter/material.dart';

import '../actions/item_filter.dart';
import '/Appstate/appstate.dart';
import '/actions/actions.dart';
import 'package:redux/redux.dart';

import '../model/model.dart';

List<Item> addItemReducer(List<Item> previousItems, AddItemAction action) {
  return previousItems = [...previousItems, action.item];
}

List<Item> removeItemReducer(List<Item> previousItems, RemoveAction action) {
  previousItems.removeAt(action.index);
  return previousItems;
}

List<Item> toggleItemSelectionReducer(
    List<Item> previousItems, ToggleItemSelection action) {
List<Item> updateItemInList(List<Item> items, int index) {
    return items.map((item) => item.index == index ? item.copyWith(isSelected: newValue) : item).toList();
}
}

ItemFilter itemFilterReducer(AppState state, action) {
  if (action is ChangeFilterAction) {
    return action.filter;
  } else {
    return state.filter;
  }
}

Reducer<List<Item>> itemsReducer = combineReducers<List<Item>>([
  TypedReducer<List<Item>, AddItemAction>(addItemReducer),
  TypedReducer<List<Item>, RemoveAction>(removeItemReducer),
  TypedReducer<List<Item>, ToggleItemSelection>(toggleItemSelectionReducer)
]);

AppState appStateReducer(AppState oldState, action) => AppState(
    itemListState: itemsReducer(oldState.itemListState, action),
    filter: itemFilterReducer(oldState, action));

// OLD Iteration of code below !!

// final itemReducer = combineReducers<AppState>([
//   TypedReducer<AppState, AddItemAction>(addItemReducer),
//   TypedReducer<AppState, RemoveAction>(removeItemReducer),
//   // TypedReducer<AppState, ToggleItemSelection>(toggleItemSelectionReducer),
//   // TypedReducer<AppState, EditItemAction>(editItemReducer),
//   // TypedReducer<AppState, UpdateStateAction>(updateStateReducer),
//   TypedReducer<AppState, AddAllItemAction>(addAllItemReducer),
// ]);

// AppState editItemReducer(AppState state, EditItemAction action) {
//   Item modifiedItem = state.itemListState.elementAt(action.index);
//   modifiedItem.title = action.name;
//   if (modifiedItem.done == true) {
//     modifiedItem.done = false;
//   }
//   state.itemListState
//       .replaceRange(action.index, action.index + 1, [modifiedItem]);
//   return state.copyWith(state.itemListState);
// }

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

// AppState updateStateReducer(AppState state, UpdateStateAction action) {
//   return action.newState;
// }

// AppState toggleItemSelectionReducer(
//     AppState state, ToggleItemSelection action) {
//   // Create a copy of the list
//   Item modifiedItem = state.itemListState
//       .elementAt(action.index); // Retrieve the element at the specified index
//   modifiedItem.done = !modifiedItem.done; // Toggle the done property
//   state.itemListState.replaceRange(action.index, action.index + 1, [
//     modifiedItem
//   ]); // Replace the element in the list with the modified element
//   return state.copyWith(state
//       .itemListState); // Return a copy of the current state with the updated list of items
// }
