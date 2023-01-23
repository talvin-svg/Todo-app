import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:todo_new/reducers/reducer.dart';
import 'package:todo_new/screens/homepage_revamped.dart';
import 'package:todo_new/screens/signin.dart';
import 'package:todo_new/screens/todo_review.dart';
import '/screens/signup.dart';
import '/screens/welcome_screen.dart';
import 'Appstate/appstate.dart';

Future<void> main() async {
  final store =
      Store<AppState>(appStateReducer, initialState: AppState.initial());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: Scaffold(
          body: MyApp(store: store),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.store,
  }) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onUnknownRoute: (settings) => MaterialPageRoute(
            settings: settings, builder: (context) => const WelcomeScreen()),
        routes: {
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          SignUpPage.id: (context) => const SignUpPage(),
          SignInPage.id: (context) => const SignInPage(),
          HompePageToo.id: (context) => const HompePageToo(),
          TodoReview.id: (context) => const TodoReview(),
        },
        title: 'Flutter Demo',
        home: const HompePageToo());
  }
}
