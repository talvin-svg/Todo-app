import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:todo_new/components/app_text.dart';
import 'package:todo_new/components/custom_button.dart';

import 'package:todo_new/screens/signup.dart';
import '../components/dismissed_container.dart';
import '/actions/actions.dart';
import '/reducers/reducer.dart';
import 'package:redux/redux.dart';
import '/Appstate/appstate.dart';
import '/components/my_button.dart';
import '/model/model.dart';
import '/components/text_card.dart';
import 'package:flutter/material.dart';

final store =
    Store<AppState>(itemReducer, initialState: AppState(itemListState: []));

class MyHomePage extends StatefulWidget {
  static const String id = 'homy';
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late bool result;
  final _dialogController = TextEditingController();
  final _dialogOnConfirmController = TextEditingController();
  var listName = store.state.itemListState;
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

  addToList() {
    final enteredtitle = _dialogController.text;
    if (enteredtitle.isEmpty) {
      return;
    }
    print('before update, ${store.state.itemListState.length}');
    // list.add(x);
    store.dispatch(AddItemAction(item: Item(title: enteredtitle)));

    print('after update,  ${store.state.itemListState.last.title}');
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: StoreConnector<AppState, _ViewModel>(
          converter: ((store) => _ViewModel(context: context, store: store)),
          builder: (BuildContext context, _ViewModel viewModel) => Scaffold(
            appBar: AppBar(
              leading: MyButton(
                name: 'back',
                color: Colors.teal,
                ontap: () {
                  try {
                    _navigateToSignUpPage();
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              title: const Text('create todo'),
            ),
            body: SingleChildScrollView(
              child: SizedBox(
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
                        background: const CustomDismissedContainer(
                          name: "EDIT",
                          isDelete: false,
                          color: Colors.green,
                          icon: Icons.edit,
                        ),
                        secondaryBackground: const CustomDismissedContainer(
                            isDelete: true,
                            color: Colors.red,
                            icon: Icons.delete),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.endToStart) {
                            viewModel.store
                                .dispatch(RemoveAction(index: index));
                          }
                        },
                        key: PageStorageKey(
                            viewModel.store.state.itemListState[index]),
                        child: TextCard(
                          iconSecondary: Icons.edit,
                          ontapIconSecondary: () {
                            editDialog(context, index);
                          },
                          time: viewModel.store.state.itemListState[index]
                                  .createdAt.year
                                  .toString() +
                              viewModel.store.state.itemListState[index]
                                  .createdAt.month
                                  .toString(),
                          todoName:
                              '${viewModel.store.state.itemListState[index].title}',
                          icon: viewModel.store.state.itemListState[index].done
                              ? Icons.check_circle_outline_outlined
                              : Icons.circle_outlined,
                          ontapIcon: () {
                            setState(() {});
                            store.dispatch(ToggleItemSelection(index: index));
                          },
                          color:
                              viewModel.store.state.itemListState[index].done ==
                                      false
                                  ? Colors.red
                                  : Colors.green,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _dialog(context);
              },
              tooltip: 'add todo',
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> editDialog(BuildContext context, int index) {
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
                  name: 'add',
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

  Future<dynamic> _dialog(BuildContext context) {
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
                      addToList();
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
