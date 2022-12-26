import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:todo_new/components/app_text.dart';
import 'package:todo_new/components/custom_button.dart';
import 'package:todo_new/components/scaffold_error_message.dart';
import 'package:todo_new/components/todo_manager.dart';

import 'package:todo_new/screens/signup.dart';
import '../async_actions.dart';
import '../components/dismissed_container.dart';
import '/actions/actions.dart';
import '/reducers/reducer.dart';
import 'package:redux/redux.dart';
import '/Appstate/appstate.dart';
import '/components/my_button.dart';
import '/model/model.dart';
import '/components/text_card.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  static const String id = 'homy';
  const MyHomePage({
    Key? key,
    required Store<AppState> store,
  }) : super(key: key);

  final store = Store<AppState>;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late bool result;
  final _dialogController = TextEditingController();
  final _dialogOnConfirmController = TextEditingController();
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  void _navigateToSignUpPage() {
    debugPrint("Navigating to SignUpPage...");
    Navigator.pushNamed(context, SignUpPage.id);
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        print(user.uid);
      }
    });
  }

  @override
  void dispose() {
    _dialogController.dispose();
    _dialogOnConfirmController.dispose();
    super.dispose();
  }

  addToList(Store<AppState> store) {
    final enteredtitle = _dialogController.text;
    if (enteredtitle.isEmpty) {
      return;
    }
    print('before update, ${store.state.itemListState.length}');
    // list.add(x);
    store.dispatch(AddItemAction(item: Item(title: enteredtitle)));
    TodoManager.notCompletedCounter++;

    print('after update,  ${store.state.itemListState.last.title}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StoreConnector<AppState, _ViewModel>(
          converter: ((store) => _ViewModel(context: context, store: store)),
          builder: (BuildContext context, _ViewModel viewModel) => Scaffold(
                appBar: AppBar(
                  leading: MyButton(
                    name: 'back',
                    color: Colors.teal,
                    ontap: () async {
                      try {
                        await signOut();
                        _navigateToSignUpPage();
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                  title: const Text('create todo'),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 500,
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: viewModel.store.state.itemListState.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Dismissible(
                                // direction: DismissDirection.endToStart,
                                resizeDuration: const Duration(seconds: 1),
                                direction: DismissDirection.endToStart,
                                background: const CustomDismissedContainer(
                                    isDelete: true,
                                    color: Colors.red,
                                    icon: Icons.delete),
                                onDismissed: (direction) {
                                  TodoManager.completedCounter--;
                                  viewModel.store
                                      .dispatch(RemoveAction(index: index));
                                  previewSuccess(
                                      message: 'todo item deleted',
                                      context: context);
                                },
                                key: PageStorageKey(
                                    viewModel.store.state.itemListState[index]),
                                child: TextCard(
                                  iconSecondary: Icons.edit,
                                  ontapIconSecondary: () {
                                    editDialog(context, index, viewModel.store);
                                  },
                                  time: viewModel.store.state
                                          .itemListState[index].createdAt.year
                                          .toString() +
                                      viewModel.store.state.itemListState[index]
                                          .createdAt.month
                                          .toString(),
                                  todoName:
                                      '${viewModel.store.state.itemListState[index].title}',
                                  icon: viewModel
                                          .store.state.itemListState[index].done
                                      ? Icons.check_circle_outline_outlined
                                      : Icons.circle_outlined,
                                  ontapIcon: () {
                                    setState(() {});
                                    viewModel.store.dispatch(
                                        ToggleItemSelection(index: index));
                                    (viewModel.store.state.itemListState[index]
                                                .done ==
                                            true)
                                        ? TodoManager.completedCounter++
                                        : TodoManager.completedCounter--;
                                    (viewModel.store.state.itemListState[index]
                                                .done ==
                                            false)
                                        ? TodoManager.notCompletedCounter++
                                        : TodoManager.notCompletedCounter--;
                                  },
                                  color: viewModel.store.state
                                              .itemListState[index].done ==
                                          false
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TodoManager(
                        text: '${TodoManager.completedCounter}',
                        color: Colors.green,
                        title: 'Completed',
                        icon: Icons.price_check_outlined,
                        isCompleted: true,
                      ),
                      TodoManager(
                        text: '${TodoManager.notCompletedCounter}',
                        color: Colors.red,
                        title: 'In Progress',
                        icon: Icons.hourglass_bottom,
                        isCompleted: true,
                      )
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    _dialog(context, viewModel.store);
                  },
                  tooltip: 'add todo',
                  child: const Icon(Icons.add),
                ),
              )),
    );
  }

  Future<dynamic> editDialog(
      BuildContext context, int index, Store<AppState> store) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Edit Todo'),
            content: TextField(
              controller: _dialogOnConfirmController,
            ),
            actions: [
              MyButton(
                  name: 'change',
                  color: Colors.teal,
                  ontap: () {
                    String entry = _dialogOnConfirmController.text;
                    if (entry.isEmpty) {
                      return;
                    } else {
                      store.dispatch(EditItemAction(
                          index: index, name: _dialogOnConfirmController.text));
                    }
                    print(
                        'after update,  ${store.state.itemListState.last.title}');
                    setState(() {
                      _dialogOnConfirmController.text = '';
                    });
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }

  Future<dynamic> _dialog(BuildContext context, Store<AppState> store) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Enter new Todo'),
            content: TextField(
              controller: _dialogController,
            ),
            actions: [
              MyButton(
                  name: 'add',
                  color: Colors.teal,
                  ontap: () {
                    setState(() {
                      addToList(store);
                      _dialogController.text = '';
                    });
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }
}

class _ViewModel {
  final BuildContext context;
  final Store<AppState> store;

  _ViewModel({required this.context, required this.store});
}
