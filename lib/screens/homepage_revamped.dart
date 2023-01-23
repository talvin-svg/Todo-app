import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:todo_new/Appstate/appstate.dart';
import 'package:todo_new/actions/actions.dart';
import 'package:todo_new/components/constants.dart';
import 'package:todo_new/components/custom_button.dart';
import 'package:todo_new/components/scaffold_error_message.dart';
import 'package:todo_new/model/model.dart';
import 'package:todo_new/screens/todo_review.dart';

import '../components/app_text.dart';
import '../components/text_card.dart';

class HompePageToo extends StatefulWidget {
  static const String id = 'homy';
  final store = Store<AppState>;
  const HompePageToo({super.key});

  @override
  State<HompePageToo> createState() => _HompePageTooState();
}

class _HompePageTooState extends State<HompePageToo> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = '';
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (() {
                Navigator.pushNamed(context, TodoReview.id);
              }),
              icon: const Icon(Icons.next_plan_outlined))
        ],
        leading: const IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: null,
        ),
        title: const AppText(
          text: 'Todo Page',
          fontSize: 30,
        ),
      ),
      body: StoreConnector<AppState, _ViewModel>(
        converter: (store) => _ViewModel(context: context, store: store),
        builder: (context, vm) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(controller: controller),
              spaceVertical,
              Row(
                children: [
                  spaceHorizontal,
                  CustomButton(
                      title: 'Add',
                      ontap: () {
                        if (controller.text.isNotEmpty) {
                          final item = controller.text;
                          vm.store
                              .dispatch(AddItemAction(item: Item(title: item)));
                          controller.text = '';
                        } else {
                          previewError(
                              message: 'field is empty', context: context);
                        }
                      },
                      color: Colors.blue),
                  spaceHorizontal,
                ],
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: vm.store.state.itemListState.length,
                      itemBuilder: ((context, index) {
                        final item =
                            vm.store.state.itemListState.elementAt(index);

                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextCard(
                              time: item.done.toString(),
                              todoName: item.title,
                              icon: Icons.delete,
                              ontapIcon: () {
                                vm.store.dispatch(RemoveAction(index: index));
                              },
                              iconSecondary: Icons.check,
                              ontapIconSecondary: () {
                                vm.store.dispatch(
                                    ToggleItemSelection(index: index));
                                print(item.done.toString());
                              },
                              color: item.done == false
                                  ? Colors.red
                                  : Colors.green),
                        );
                      })))
            ],
          );
        },
      ),
    );
  }
}

class _ViewModel {
  final BuildContext context;
  final Store<AppState> store;

  const _ViewModel({required this.context, required this.store});

  List<dynamic> get filtered => store.state.filteredItems;
  List<Item> get itemList => store.state.itemListState;
}
