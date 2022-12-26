import 'package:flutter_redux/flutter_redux.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo_new/components/constants.dart';
import 'package:todo_new/screens/signup.dart';
import '/actions/actions.dart';
import '/reducers/reducer.dart';
import 'package:redux/redux.dart';
import '/Appstate/appstate.dart';
import '/components/my_button.dart';
import '/model/model.dart';
import '/components/text_card.dart';
import 'package:flutter/material.dart';
import 'package:todo_new/screens/welcome_screen.dart';

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
  }

  @override
  void dispose() {
    _dialogController.dispose();
    super.dispose();
  }

  void getItemList() {
    for (var x = 0; x <= store.state.itemListState.length; x++) {
      print('${listName[x].title} + ${listName[x].done}');
    }
  }

  addToList() {
    final enteredtitle = _dialogController.text;
    if (enteredtitle.isEmpty) {
      return;
    }
    print('before update, ${store.state.itemListState}');
    // list.add(x);
    store.dispatch(AddItemAction(item: Item(title: enteredtitle)));
    getItemList();

    print(
        'after update,  ${store.state.itemListState[store.state.itemListState.length]}');
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
              title: Text('create todo'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    reverse: true,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: store.state.itemListState.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Dismissible(
                              background: Container(color: Colors.red),
                              onDismissed: (direction) =>
                                  store.dispatch(RemoveAction(index: index)),
                              key: PageStorageKey(
                                  store.state.itemListState[index]),
                              child: TextCard(
                                todoName:
                                    '${store.state.itemListState[index].title}',
                                icon: store.state.itemListState[index].done
                                    ? Icons.check_circle_outline_outlined
                                    : Icons.circle_outlined,
                                ontapIcon: () {
                                  // bool done =
                                  //     store.state.itemListState[index].done;
                                  // done = !done;
                                  // store.state.itemListState[index].done = done;
                                  setState(() {});
                                  store.dispatch(
                                      ToggleItemSelection(index: index));
                                },
                              ),
                            ),
                          );
                        })),
                  )
                ],
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
