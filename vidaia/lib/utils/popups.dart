

import 'package:flutter/material.dart';

oneButtonPopup(BuildContext context, Text title, Text content) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: title,
    content: content,
    actions: [
      cancelButton,
    ],
  );
  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}