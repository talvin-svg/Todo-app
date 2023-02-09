import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:todo_new/Appstate/appstate.dart';
import 'package:todo_new/Appstate/reducer.dart';

import 'package:todo_new/components/todo_manager.dart';

import 'package:todo_new/list/state.dart';

import '../components/app_text.dart';
import '../components/constants.dart';
import '../components/custom_button.dart';
import 'package:todo_new/list/model.dart';

class TodoReview extends StatefulWidget {
  const TodoReview({super.key});
  static const String id = 'viewy';
  @override
  State<TodoReview> createState() => _TodoReviewState();
}

class _TodoReviewState extends State<TodoReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: StoreConnector<AppState, _ViewModel>(
            converter: ((store) => _ViewModel(
                store: store,
                context: context,
                lost: store.state.itemListState)),
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
                          },
                          color: Colors.blue),
                      spaceHorizontal,
                      CustomButton(
                          title: ' Completed',
                          ontap: () {
                            vm.store.dispatch(
                                const ChangeFilterAction(ItemFilter.done));
                          },
                          color: Colors.blue),
                      spaceHorizontal,
                    ],
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: vm.filtered.length,
                          itemBuilder: ((context, index) {
                            final Item item = vm.filtered.elementAt(index);

                            return ListTile(
                              title: AppText(text: item.title),
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
  const _ViewModel({required this.store, required this.context, required lost});

  List<Item> get filtered => store.state.filteredItems;

  int complete() => store.state.itemListState.completed;
  int notComplete() => store.state.itemListState.notCompleted;
}
