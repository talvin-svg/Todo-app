import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:todo_new/reducers/reducer.dart';
import 'package:todo_new/screens/homepage.dart';
import 'package:todo_new/screens/signin.dart';
import '/screens/signup.dart';
import '/screens/welcome_screen.dart';
import 'Appstate/appstate.dart';
import 'async_actions.dart';

Future<void> main() async {
//   Future<AppState> getAppStateFromFirestore() async {
//     UserCredential User = await _signIn();
//   DocumentSnapshot snapshot = await FirebaseFirestore.instance
//   .collection('todos')
//   .doc('userId')
//   .get();

//   if(!snapshot.exists){
//     return AppState.intial();
//   }

//   Map<String , dynamic>? data = snapshot.data as Map<String , dynamic>?;

//   AppState appState = AppState.fromMap(data);
//   return appState;
// }

  final store = Store<AppState>(itemReducer, initialState: AppState.intial());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: Scaffold(
        body: MyApp(store: store),
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
        MyHomePage.id: (context) => const MyHomePage(),
      },
      title: 'Flutter Demo',
      home: const MyHomePage(),
    );
  }
}
