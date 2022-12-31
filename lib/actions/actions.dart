import '../Appstate/appstate.dart';

class AddItemAction {
  dynamic item;
  AddItemAction({required this.item});
}

class AddAllItemAction {
  List<dynamic> items;
  AddAllItemAction({required this.items});
}

class RemoveAction {
  int index;
  RemoveAction({required this.index});
}

class ToggleItemSelection {
  dynamic index;

  ToggleItemSelection({required this.index});
}

class EditItemAction {
  dynamic index, name;

  EditItemAction({required this.index, required this.name});
}

class UpdateStateAction {
  final AppState newState;
  UpdateStateAction(this.newState);
}
