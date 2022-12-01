import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:newwer_todo/actions/actions.dart';
import 'package:newwer_todo/reducers/reducer.dart';
import 'package:newwer_todo/screens/welcome_screen.dart';
import 'package:redux/redux.dart';
import 'Appstate/appstate.dart';
import 'components/my_button.dart';
import 'model/model.dart';
import 'components/text_card.dart';

final store =
    Store<AppState>(itemReducer, initialState: AppState(itemListState: []));

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/welcomeScreen': (context) => WelcomeScreen()},
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _dialogController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
    print('before update, ${store.state.itemListState}');
    // list.add(x);
    store.dispatch(AddItemAction(item: Item(title: enteredtitle)));

    print('after update,  ${store.state.itemListState}');
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
              title: Text(widget.title),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: store.state.itemListState.length,
                      itemBuilder: ((context, index) {
                        return Dismissible(
                          background: Container(color: Colors.red),
                          onDismissed: (direction) =>
                              store.dispatch(RemoveAction(index: index)),
                          key: PageStorageKey(store.state.itemListState[index]),
                          child: TextCard(
                            name: '${store.state.itemListState[index].title}',
                            ontap: () {},
                          ),
                        );
                      }))
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
                              color: Colors.grey,
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
