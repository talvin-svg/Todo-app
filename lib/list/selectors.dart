import 'package:redux/redux.dart';
import 'package:todo_new/Appstate/appstate.dart';
import 'package:todo_new/list/model.dart';
import 'package:intl/intl.dart';

List<Item> selectItemsByDay(String day, Store<AppState> store) {
  List<Item> items = store.state.filteredItems;
  return items
      .where((item) =>
          DateFormat('EE').format(item.dueDate ?? DateTime.now()) == day)
      .toList();
}
