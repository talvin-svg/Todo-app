import 'package:todo_new/list/model.dart';

enum ItemFilter { all, done, active }

class ItemListState {
  const ItemListState({this.itemList = const []});

  final List<Item> itemList;

  factory ItemListState.initial() => const ItemListState();

  ItemListState copyWith(List<Item>? itemList) {
    return ItemListState(
      itemList: itemList ?? this.itemList,
    );
  }

  int get completed {
    return itemList.where((e) => e.done == true).toList().length;
  }

  int get notCompleted {
    return itemList.where((e) => e.done == false).toList().length;
  }
}
