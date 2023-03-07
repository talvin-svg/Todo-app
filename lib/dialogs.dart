import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_new/components/app_text.dart';

showYesNoActionSheet(
    {required BuildContext context,
    required String message,
    required Function onYesClicked,
    GlobalKey<ScaffoldState>? key}) {
  CupertinoActionSheet actionSheet = CupertinoActionSheet(
    message: AppText(
      text: message,
      textAlign: TextAlign.center,
    ),
    actions: [
      CupertinoActionSheetAction(
        onPressed: () {
          onYesClicked();
        },
        child: const AppText(text: 'Yes'),
      ),
      CupertinoActionSheetAction(
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        child: const AppText(
          text: 'Cancel',
          color: Colors.red,
        ),
      ),
    ],
  );
  showCupertinoModalPopup(
      context: context, builder: (BuildContext context) => actionSheet);
}
