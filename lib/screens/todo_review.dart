import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:todo_new/Appstate/appstate.dart';
import 'package:todo_new/actions/item_filter.dart';
import 'package:todo_new/components/todo_manager.dart';

import '../actions/actions.dart';
import '../components/app_text.dart';
import '../components/constants.dart';
import '../components/custom_button.dart';
import '../model/model.dart';

class TodoReview extends StatefulWidget {
  const TodoReview({super.key});
  static const String id = 'viewy';
  @override
  State<TodoReview> createState() => _TodoReviewState();
}

class _TodoReviewState extends State<TodoReview> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: StoreConnector<AppState, _ViewModel>(
            converter: ((store) => _ViewModel(store: store, context: context)),
            builder: (context, vm) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TodoManager(
                            color: Colors.grey,
                            title: 'In Progress ',
                            icon: Icons.toys_sharp,
                            text: '${vm.notComplete()}'),
                      ),
                      spaceHorizontal,
                      Expanded(
                        child: TodoManager(
                            color: Colors.green,
                            title: 'Completed',
                            icon: Icons.abc_outlined,
                            text: '${vm.complete()}'),
                      ),
                    ],
                  ),
                  spaceVertical,
                  Row(
                    children: [
                      spaceHorizontal,
                      CustomButton(
                          title: 'Show All',
                          ontap: () {
                            vm.store.dispatch(
                                const ChangeFilterAction(ItemFilter.all));
                            controller.text = '';
                          },
                          color: Colors.blue),
                      spaceHorizontal,
                      CustomButton(
                          title: ' Completed',
                          ontap: () {
                            vm.store.dispatch(
                                const ChangeFilterAction(ItemFilter.done));
                            controller.text = '';
                          },
                          color: Colors.blue),
                      spaceHorizontal,
                    ],
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: vm.store.state.filteredItems.length,
                          itemBuilder: ((context, index) {
                            final item =
                                vm.store.state.filteredItems.elementAt(index);

                            return ListTile(
                              title: AppText(text: item.title),
                              trailing: IconButton(
                                  onPressed: () {
                                    vm.store.dispatch(RemoveAction(
                                      index: index,
                                    ));
                                  },
                                  icon: const Icon(Icons.delete)),
                            );
                          })))
                ],
              );
            }));
  }
}

class _ViewModel {
  final BuildContext context;
  final Store<AppState> store;
  const _ViewModel({required this.store, required this.context});
  List<dynamic> get filtered => store.state.filteredItems;

  int complete() => store.state.completed;
  int notComplete() => store.state.notCompleted;
}
