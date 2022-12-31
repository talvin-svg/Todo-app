import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
  final _dialogController = TextEditingController();
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
                        direction: DismissDirection.endToStart,
                        resizeDuration: const Duration(seconds: 1),
                        background: const CustomDismissedContainer(
                          color: Colors.red,
                          icon: Icons.delete,
                        ),
                        onDismissed: (direction) =>
                            store.dispatch(RemoveAction(index: index)),
                        key: PageStorageKey(
                            viewModel.store.state.itemListState[index]),
                        child: TextCard(
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
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
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
              },
              tooltip: 'add todo',
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}

class _ViewModel {
  final BuildContext context;
  final Store<AppState> store;

  _ViewModel({required this.context, required this.store});
}