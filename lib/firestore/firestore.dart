import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:redux/redux.dart';
import 'package:todo_new/Appstate/appstate.dart';

class Firestore {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static Map<String, dynamic> cleanData(Map<String, dynamic> data) {
    return Map.fromEntries(data.entries.where((entry) => entry.value != null));
  }

  static String generateDocCode({required String startsWith}) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    Random rnd = Random();
    String code = String.fromCharCodes(Iterable.generate(
        17, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
    return startsWith.toUpperCase() + code;
  }

  static Future createDocument({
    required String collectionPath,
    required String code,
    bool isFirestoreCode = false,
    // required String loadingKey,
    required Map<String, dynamic> data,
    required Function(String) onSuccess,
    required Store<AppState> store,
  }) async {
    String generatedCode = generateDocCode(startsWith: code);
    // store.dispatch(StartLoadingAction(loadingKey: loadingKey));
    try {
      data["code"] = isFirestoreCode ? code : generatedCode;
      await db
          .collection(collectionPath)
          .doc(isFirestoreCode ? code : generatedCode)
          .set(cleanData(data));
      onSuccess(isFirestoreCode ? code : generatedCode);
    } on FirebaseException catch (e) {
      print(e);
      // store.dispatch(StopLoadingAction(loadingKey: loadingKey));
      return null;
    } on Exception catch (e) {
      print(e);
      // store.dispatch(StopLoadingAction(loadingKey: loadingKey));
      return null;
    }
    // store.dispatch(StopLoadingAction(loadingKey: loadingKey));
    return isFirestoreCode ? code : generatedCode;
  }
}
