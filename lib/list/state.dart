import 'package:todo_new/actions/item_filter.dart';
import 'package:todo_new/list/model.dart';

class ItemListState {
  const ItemListState({this.itemList = const [], this.filter = ItemFilter.all});

  final List<Item> itemList;
  final ItemFilter filter;

  factory ItemListState.initial() => const ItemListState();

  ItemListState copyWith(List<Item>? itemList, ItemFilter? filter) {
    return ItemListState(
        itemList: itemList ?? this.itemList, filter: filter ?? this.filter);
  }

  List<Item> get filteredItems {
    switch (filter) {
      case ItemFilter.all:
        return itemList;
      case ItemFilter.done:
        return itemList.where((e) => e.done == true).toList();
    }
  }

  int get completed {
    return itemList.where((e) => e.done == true).toList().length;
  }

  int get notCompleted {
    return itemList.where((e) => e.done == false).toList().length;
  }
}
