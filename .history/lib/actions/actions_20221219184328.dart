class AddItemAction {
  dynamic item;
  AddItemAction({required this.item});
}

class RemoveAction {
  int index;
  RemoveAction({required this.index});
}

class ToggleItemSelection {
  dynamic index;

  ToggleItemSelection({this.index});
}
