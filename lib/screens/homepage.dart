import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:todo_new/components/scaffold_error_message.dart';
import 'package:todo_new/components/todo_manager.dart';
import 'package:todo_new/screens/signup.dart';
import '../async_actions.dart';
import '../components/dismissed_container.dart';
import '/actions/actions.dart';
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
    required this.store,
  }) : super(key: key);

  final Store<AppState> store;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isCompleted = false;
  late bool result;
  final _dialogController = TextEditingController();
  final _dialogOnConfirmController = TextEditingController();
  final CollectionReference users =
      FirebaseFirestore.instance.collection('newUsers');
  var firebaseUser = FirebaseAuth.instance.currentUser;
  void _navigateToSignUpPage() {
    debugPrint("Navigating to SignUpPage...");
    Navigator.pushNamed(context, SignUpPage.id);
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

    print(
        'after update,  ${store.state.itemListState.last.title} , ${store.state.itemListState.length}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StoreConnector<AppState, _ViewModel>(
          converter: ((store) => _ViewModel(context: context, store: store)),
          builder: (BuildContext context, _ViewModel viewModel) {
            return Scaffold(
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
                              confirmDismiss: (direction) async {
                                return (viewModel.store.state
                                        .itemListState[index].done ==
                                    true);
                              },
                              // direction: DismissDirection.endToStart,
                              resizeDuration: const Duration(seconds: 1),
                              direction: DismissDirection.endToStart,
                              background: const CustomDismissedContainer(
                                  isDelete: true,
                                  color: Colors.red,
                                  icon: Icons.delete),
                              onDismissed: (direction) {
                                print(
                                    'before deletion ${viewModel.store.state.itemListState.length}');
                                TodoManager.completedCounter--;
                                viewModel.store
                                    .dispatch(RemoveAction(index: index));
                                print(
                                    'after deletion ${viewModel.store.state.itemListState.length},  ${viewModel.store.state.itemListState.last.title} ');
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
                                time: viewModel.store.state.itemListState[index]
                                        .createdAt.year
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
                                  if (viewModel.store.state.itemListState[index]
                                          .done ==
                                      true) {
                                    Map<String, dynamic> dataToSave = {
                                      'done': !isCompleted,
                                    };

                                    FirebaseFirestore.instance
                                        .collection('newUsers')
                                        .doc(firebaseUser!.uid)
                                        .collection('todos')
                                        .doc(firebaseUser!.uid)
                                        .update(dataToSave);
                                  } else {
                                    Map<String, dynamic> dataToSave = {
                                      'done': isCompleted,
                                    };

                                    FirebaseFirestore.instance
                                        .collection('newUsers')
                                        .doc(firebaseUser!.uid)
                                        .collection('todos')
                                        .doc(firebaseUser!.uid)
                                        .update(dataToSave);
                                  }

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
            );
          }),
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
                    // Map<String, dynamic> dataToSave = {
                    //   'title': _dialogController.text,
                    //   'done': isCompleted,
                    //   'createdAt': 5
                    // };
                    final newItem =
                        // Item(title: _dialogController.text);

                        {
                      'title': _dialogController.text,
                      'done': false,
                      'createdAt': DateTime.now()
                    };

                    print(firebaseUser!.email);

                    FirebaseFirestore.instance
                        .collection('newUsers')
                        .doc(firebaseUser!.uid)
                        .update({
                      'items': FieldValue.arrayUnion([newItem])
                    });

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
