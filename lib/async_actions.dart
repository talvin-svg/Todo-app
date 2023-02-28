import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:todo_new/Appstate/appstate.dart';
import 'package:todo_new/Appstate/reducer.dart';
import 'package:todo_new/firestore/firestore.dart';
import 'package:todo_new/list/actions/actions.dart';
import 'package:todo_new/list/state.dart';

import 'package:todo_new/screens/intro_screenpage.dart';

import 'components/scaffold_error_message.dart';
import 'components/text_field_validator.dart';
import 'package:todo_new/list/model.dart';

//TODO fix this page.

Future<void> signOut() async {
  try {
    await Firestore.firebaseAuth.signOut();
  } catch (e) {
    print(e);
  }
}

Future signIn(
    {required String email,
    required String password,
    required BuildContext context}) async {
  bool onSuccess = false;
  if (!isLoginFieldsValid(email, password)) {
    previewError(context: context, message: 'Fields not filled in correctly!');
    return;
  }
  await signOut();
  try {
    var result = await Firestore.firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    onSuccess = true;
    previewSuccess(
        message: 'Welcome Back!, Lets get to work', context: context);

    Future.delayed(const Duration(seconds: 4), (() {
      (onSuccess)
          ? Navigator.pushNamed(context, IntroScreen.id)
          : previewError(
              message: 'Account could not be created at this time',
              context: context);
    }));
    return;
  } catch (e) {
    print(e.toString());
    return;
  }
}

addTodo(DateTime? date,
    {required BuildContext context,
    required Store<AppState> store,
    required String details,
    required String title,
    required Color color,
    required Categories category}) {
  if (details.isNotEmpty && title.isNotEmpty) {
    store.dispatch(
      AddItemAction(
        item: Item(
          category: category,
          createdAt: DateTime.now(),
          title: title,
          details: details,
          dueDate: date,
          color: color,
        ),
      ),
    );
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

editTodo(
    {required BuildContext context,
    required Store<AppState> store,
    required String details,
    required String title,
    required int index}) {
  store.dispatch(EditItemAction(index: index, title: title, details: details));
}

deleteTodo(
    {required BuildContext context,
    required Store<AppState> store,
    required int index}) {
  store.dispatch(RemoveAction(index: index));
}

completeTodo(
    {required BuildContext context,
    required Store<AppState> store,
    required int index}) {
  store.dispatch(ToggleItemSelection(index: index));
}
