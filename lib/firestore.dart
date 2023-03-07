import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/redux.dart';
import 'package:todo_new/Appstate/appstate.dart';
import 'package:todo_new/loading/actions.dart';

class Firestore {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

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
    required String loadingKey,
    required Map<String, dynamic> data,
    required Store<AppState> store,
    required Function onSuccess,
  }) async {
    store.dispatch(StartLoadingAction(loadingKey: loadingKey));
    try {
      await db.collection(collectionPath).doc(code).set(cleanData(data));
      onSuccess();
    } on FirebaseException catch (e) {
      print(e);
      store.dispatch(StopLoadingAction(loadingKey: loadingKey));
      return null;
    }
    store.dispatch(StopLoadingAction(loadingKey: loadingKey));
    return code;
  }

  static Map<String, dynamic> cleanData(Map<String, dynamic> data) {
    Map<String, dynamic> cleanedData = {};
    data.forEach((key, value) {
      if (value != null) {
        cleanedData.addAll({key: value});
      }
    });
    return cleanedData;
  }

  static Future updateDocument({
    required Store<AppState> store,
    required String collectionPath,
    required String loadingKey,
    required String docPath,
    required Map<String, dynamic> data,
    Function? onSuccess,
  }) async {
    store.dispatch(StartLoadingAction(loadingKey: loadingKey));
    try {
      DocumentReference doc = db.collection(collectionPath).doc(docPath);
      if (!(await doc.get()).exists) {
        print('error');
        // await doc.update(cleanData(data));
        if (onSuccess != null) onSuccess;
      }
    } on FirebaseException catch (e) {
      print(e);
    } on Exception catch (e) {
      print(e);
    }
    store.dispatch(StopLoadingAction(loadingKey: loadingKey));
  }
}
