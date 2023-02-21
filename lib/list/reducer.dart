import 'package:todo_new/list/actions/actions.dart';
import 'package:todo_new/list/model.dart';
import 'package:todo_new/list/state.dart';

import 'package:redux/redux.dart';

ItemListState addItemReducer(
    ItemListState previousItems, AddItemAction action) {
  var newItems =
      previousItems.copyWith([...previousItems.itemList, action.item]);
  return newItems;
}

ItemListState removeItemReducer(
    ItemListState previousItems, RemoveAction action) {
  previousItems.itemList.removeAt(action.index);
  return previousItems;
}

ItemListState toggleItemSelectionReducer(
    ItemListState previousItems, ToggleItemSelection action) {
  Item modifiedItem = previousItems.itemList.elementAt(action.index);
  modifiedItem.done = !modifiedItem.done;
  previousItems.itemList
      .replaceRange(action.index, action.index + 1, [modifiedItem]);
  return previousItems;
}

ItemListState editItemReducer(
    ItemListState previousItems, EditItemAction action) {
  Item modifiedItem = previousItems.itemList.elementAt(action.index);
  modifiedItem.title = action.title;
  modifiedItem.details = action.details;
  previousItems.itemList
      .replaceRange(action.index, action.index + 1, [modifiedItem]);
  return previousItems;
}

Reducer<ItemListState> itemsReducer = combineReducers<ItemListState>([
  TypedReducer<ItemListState, AddItemAction>(addItemReducer),
  TypedReducer<ItemListState, RemoveAction>(removeItemReducer),
  TypedReducer<ItemListState, ToggleItemSelection>(toggleItemSelectionReducer),
  TypedReducer<ItemListState, EditItemAction>(editItemReducer),
]);
