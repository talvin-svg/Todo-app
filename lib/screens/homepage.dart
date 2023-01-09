import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:todo_new/components/scaffold_error_message.dart';
import 'package:todo_new/components/todo_manager.dart';
import 'package:todo_new/reducers/reducer.dart';
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
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference todosInstance =
      FirebaseFirestore.instance.collection('todos');
  Stream<QuerySnapshot> fireStream =
      FirebaseFirestore.instance.collection('todos').snapshots();
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

  Stream<List<Item>> readTodos() => FirebaseFirestore.instance
      .collection("todos")
      .orderBy('createdAt')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Item.fromMap(doc.data())).toList());

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

  Future createTodo(Item item) async {
    final docTodo = FirebaseFirestore.instance.collection("todos").doc();
    item.id = docTodo.id;
    final json = item.toMap();
    await docTodo.set(json);
    print(item.id);
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
          body: StreamBuilder<List<Item>>(
              stream: readTodos(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error with code'),
                  );
                }

                print(snapshot.data!);
                final todoItems = snapshot.data!;
                // List<dynamic> list = viewModel.store.state.itemListState;

                if (todoItems.isEmpty) {
                  return const Center(
                    child: Text('Try creating a new todo list!'),
                  );
                }

                return ListView.builder(
                  itemCount: todoItems.length,
                  itemBuilder: (context, index) {
                    final onItem = todoItems[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Dismissible(
                        confirmDismiss: (direction) async {
                          return (onItem.done == true);
                        },
                        direction: DismissDirection.endToStart,
                        resizeDuration: const Duration(seconds: 1),
                        background: const CustomDismissedContainer(
                            color: Colors.red,
                            icon: Icons.delete,
                            isDelete: true),
                        onDismissed: (direction) async {
                          print('before deletion ${todoItems.length}');
                          TodoManager.completedCounter--;
                          // viewModel.store.dispatch(RemoveAction(index: index));
                          if (todoItems.isNotEmpty) {
                            final doc = FirebaseFirestore.instance
                                .collection('todos')
                                .doc(onItem.id);

                            final docSnapshot = await doc.get();
                            if (docSnapshot.exists) {
                              doc.delete();
                            }
                          }

                          print(
                              'after deletion ${todoItems.length},  ${todoItems.last.title}');
                          previewSuccess(
                              message: 'todo item deleted', context: context);
                        },
                        key: PageStorageKey(todoItems[index]),
                        child: TextCard(
                          iconSecondary: Icons.edit,
                          todoName: onItem.title ?? 'error getting todo',
                          ontapIcon: () async {
                            if (todoItems.isNotEmpty) {
                              final doc = FirebaseFirestore.instance
                                  .collection('todos')
                                  .doc(onItem.id);
                              print(onItem.done);
                              final docSnapshot = await doc.get();
                              if (docSnapshot.exists) {
                                doc.update({
                                  'done': (onItem.done == true ? false : true)
                                });
                                print(onItem.done);
                              }

                              // viewModel.store
                              //     .dispatch(ToggleItemSelection(index: index));
                            }
                          },
                          ontapIconSecondary: () {
                            if (todoItems.isNotEmpty) {
                              editDialog(context, index, viewModel.store,
                                  todoItems[index].id);
                            }
                          },
                          icon: onItem.done == false
                              ? Icons.check_circle_outline_outlined
                              : Icons.circle_outlined,
                          color:
                              onItem.done == true ? Colors.green : Colors.red,
                        ),
                      ),
                    );
                  },
                );
              }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _dialog(context, viewModel.store);
            },
            tooltip: 'add todo',
            child: const Icon(Icons.add),
          ),
        );
      },
    ));
  }

  Future<dynamic> editDialog(
      BuildContext context, index, Store<AppState> store, String? documentId) {
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
                  ontap: () async {
                    firestoreEditTitle(
                        documentId, _dialogOnConfirmController.text);
                    String entry = _dialogOnConfirmController.text;
                    if (entry.isEmpty) {
                      return;
                    } else {
                      // store.dispatch(EditItemAction(
                      //     index: index, name: _dialogOnConfirmController.text));
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
                    final item = Item(title: _dialogController.text);

                    // print(firebaseUser!.email);

                    createTodo(item);
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

  void firestoreEditTitle(String? documentId, String newTodo) async {
    final doc = FirebaseFirestore.instance.collection('todos').doc(documentId);

    final docData = await doc.get();

    if (docData.exists) {
      doc.update({'title': newTodo});
    }
  }
}

class _ViewModel {
  final BuildContext context;
  final Store<AppState> store;

  _ViewModel({required this.context, required this.store});
}
