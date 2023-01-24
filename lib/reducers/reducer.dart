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
  Item modifiedItem = previousItems.elementAt(action.index);
  modifiedItem.done = !modifiedItem.done;
  previousItems.replaceRange(action.index, action.index + 1, [modifiedItem]);
  return previousItems;
}

List<Item> editItemReducer(List<Item> previousItems, EditItemAction action) {
  Item modifiedItem = previousItems.elementAt(action.index);
  modifiedItem.title = action.name;
  previousItems.replaceRange(action.index, action.index + 1, [modifiedItem]);
  return previousItems;
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
  TypedReducer<List<Item>, ToggleItemSelection>(toggleItemSelectionReducer),
  TypedReducer<List<Item>, EditItemAction>(editItemReducer),
]);

AppState appStateReducer(AppState oldState, action) => AppState(
    itemListState: itemsReducer(oldState.itemListState, action),
    filter: itemFilterReducer(oldState, action));
