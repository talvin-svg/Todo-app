class AddItemAction {
  dynamic item;
  AddItemAction({required this.item});
}

class RemoveAction {
  int index;
  RemoveAction({required this.index});
}

class ToggleItemSelection {
  dynamic item, index;

  ToggleItemSelection({this.index, this.item});
}
