import 'package:todo_new/actions/item_filter.dart';
import 'package:todo_new/actions/todo_action.dart';

import '../Appstate/appstate.dart';

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
  final dynamic index, name;
  const EditItemAction({required this.index, required this.name});
}

class ChangeFilterAction {
  final ItemFilter filter;
  const ChangeFilterAction(this.filter);
}
