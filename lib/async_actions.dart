import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:todo_new/Appstate/appstate.dart';
import 'package:todo_new/Appstate/reducer.dart';
import 'package:todo_new/db.dart';
import 'package:todo_new/dialogs.dart';
import 'package:todo_new/firestore.dart';
import 'package:todo_new/list/actions/actions.dart';
import 'package:todo_new/list/constants.dart';
import 'package:todo_new/list/selectors.dart';
import 'package:todo_new/list/state.dart';
import 'package:todo_new/loading/actions.dart';
import 'package:todo_new/screens/intro_screenpage.dart';
import 'components/scaffold_error_message.dart';
import 'components/text_field_validator.dart';
import 'package:todo_new/list/model.dart';
import 'package:firebase_auth/firebase_auth.dart' as f_auth;

//TODO fix this page.

f_auth.FirebaseAuth firebaseAuth = f_auth.FirebaseAuth.instance;

Future signUpUser({
  required String email,
  required String password,
  required BuildContext context,
  required Store<AppState> store,
  required String loadingKey,
  required Function onError,
}) async {
  store.dispatch(StartLoadingAction(loadingKey: loadingKey));
  await firebaseAuth
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((result) async {
    if (result.user == null) return;

    await Firestore.createDocument(
        loadingKey: createUserLoadingKey,
        collectionPath: 'users',
        code: result.user!.uid,
        data: {'email': result.user!.email},
        onSuccess: () {
          previewSuccess(message: 'Sign up comeplete!', context: context);
          Navigator.pushNamed(context, IntroScreen.id);
        },
        store: store);
    store.dispatch(StopLoadingAction(loadingKey: loadingKey));
  }).catchError((e) {
    onError();
    previewError(message: e.toString(), context: context);
  });
}

Future signOut({BuildContext? context}) async {
  if (context != null) {
    showYesNoActionSheet(
        context: context,
        message: 'Are you sure you want to sign out?',
        onYesClicked: () async {
          await firebaseAuth
              .signOut()
              .then((_) => Navigator.of(context, rootNavigator: true).pop())
              .then((_) => Navigator.pop(context));
        });
  }
  await firebaseAuth.signOut();
  return;
}

Future signIn(
    {required String email,
    required Store<AppState> store,
    required String password,
    required String loadingKey,
    required BuildContext context,
    Function? onSuccess}) async {
  store.dispatch(StartLoadingAction(loadingKey: loadingKey));
  if (!isLoginFieldsValid(email, password)) {
    previewError(context: context, message: 'Fields not filled in correctly!');
    return;
  }
  await signOut();

  try {
    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => (onSuccess != null) ? onSuccess() : null)
        .then((value) =>
            store.dispatch(StopLoadingAction(loadingKey: loadingKey)));
  } catch (e) {
    print(e);
    store.dispatch(StopLoadingAction(loadingKey: loadingKey));
  }
}

Future addTodo(DateTime? date,
    {required BuildContext context,
    required Store<AppState> store,
    required String details,
    required String title,
    required String loadingKey,
    required Color color,
    required String category}) async {
  String todoCode = Firestore.generateDocCode(startsWith: 'Todo');
  if (details.isNotEmpty && title.isNotEmpty) {
    store.dispatch(StartLoadingAction(loadingKey: loadingKey));

    Item item = Item(
      id: todoCode,
      category: category,
      title: title,
      details: details,
      dueDate: date,
      color: colorSelector(color),
    );
    store.dispatch(
      AddItemAction(
        item: item,
      ),
    );

    await Firestore.createDocument(
        collectionPath: 'users/$FIR_UID/todos',
        code: todoCode,
        loadingKey: loadingKey,
        data: item.toMap(),
        onSuccess: () {},
        store: store);
    store.dispatch(StopLoadingAction(loadingKey: loadingKey));
  } else {
    previewError(
        message: 'Please make sure every field is not empty', context: context);
  }
}

showActiveTodo(
    {required ItemFilter filter,
    required BuildContext context,
    required Store<AppState> store}) {
  store.dispatch(ChangeFilterAction(filter));
}

Future editTodo(
    {required BuildContext context,
    required Store<AppState> store,
    required String details,
    required String loadingKey,
    required Item item,
    required String title,
    required int index}) async {
  store.dispatch(StartLoadingAction(loadingKey: loadingKey));

  Item editItem = item.copyWith(title: title, details: details);
  final dataItem = editItem.toMap();

  await Firestore.updateDocument(
      store: store,
      collectionPath: 'users/$FIR_UID/todos',
      loadingKey: loadingKey,
      docPath: editItem.id ?? '',
      data: dataItem);

  store.dispatch(EditItemAction(index: index, title: title, details: details));
}

deleteTodo(
    {required BuildContext context,
    required Store<AppState> store,
    required String loadingKey,
    required Item item,
    required int index}) async {
  store.dispatch(StartLoadingAction(loadingKey: loadingKey));

  await Firestore.deleteDocument(
      collectionPath: 'users/$FIR_UID/todos',
      docPath: item.id ?? '',
      loadingKey: loadingKey,
      store: store);
  store.dispatch(RemoveAction(index: index));
}

Future completeTodo(
    {required BuildContext context,
    required Store<AppState> store,
    required String loadingKey,
    required Item item,
    required int index}) async {
  store.dispatch(StartLoadingAction(loadingKey: loadingKey));

  Item editItem = item.copyWith(done: true);
  final dataItem = editItem.toMap();

  await Firestore.updateDocument(
      store: store,
      collectionPath: 'users/$FIR_UID/todos',
      loadingKey: loadingKey,
      docPath: editItem.id ?? '',
      data: dataItem);
  store.dispatch(ToggleItemSelection(index: index));
}

void stopLoadingAction(
    {required String loadingKey, required Store<AppState> store}) {
  store.dispatch(StopLoadingAction(loadingKey: loadingKey));
}

Future fetchUserTodos({
  required Store<AppState> store,
}) async {
  store.dispatch(StartLoadingAction(loadingKey: fetchTodoLoadingKey));

  List<Item> todoItems = [];
  List todos = await Firestore.getDocuments(
      collectionPath: ('users/$FIR_UID/todos'),
      loadingKey: fetchTodoLoadingKey,
      store: store);

  for (var data in todos) {
    Item item = Item.fromMap(data);
    todoItems.add(item);
  }
  store.dispatch(AddAllItemAction(items: todoItems));
}
