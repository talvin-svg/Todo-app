import 'package:todo_new/list/actions/todo_action.dart';

class AddItemAction extends TodoAction {
  final dynamic item;
  const AddItemAction({required this.item});
}

class AddAllItemAction extends TodoAction {
  final List<dynamic> items;
  const AddAllItemAction({required this.items});
}

class RemoveAction extends TodoAction {
  final dynamic index;
  const RemoveAction({required this.index});
}

class ToggleItemSelection extends TodoAction {
  final dynamic index;
  const ToggleItemSelection({required this.index});
}

class EditItemAction extends TodoAction {
  final int index;
  final String title, details;
  const EditItemAction(
      {required this.index, required this.title, required this.details});
}
