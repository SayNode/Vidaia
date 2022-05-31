import 'package:flutter/material.dart';
import 'package:vidaia/utils/wallet.dart';
import 'globals.dart' as global;
import 'exceptions.dart';

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

confirmPurchase(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Purchase Confirmed"),
    content: Text("Thank you for your purchase. Your Reward will be sent to you by Email."),
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

onLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // The loading indicator
                CircularProgressIndicator(),
                SizedBox(
                  height: 15,
                ),
                // Some text
                Text('Loading...')
              ],
            ),
          ));
    },
  );
}

showMnemonicAlert(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Reminde me Later"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Back up now"),
    onPressed: () {
      Navigator.pop(context);
      showMnemonicWordsAlert(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Seed Worts not backed up"),
    content: Text("Would you like to write down your seed words now?"),
    actions: [
      cancelButton,
      continueButton,
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

showMnemonicWordsAlert(BuildContext context) async {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Finished"),
    onPressed: () {
      global.mnemonicNoted = true;
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog seed = AlertDialog(
    title: Text("Mnemonic Words"),
    content: Text(await getWords()),
    //actions: await getWordButtons(),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return seed;
    },
  );
}

txConfirmedAlert(BuildContext context, String txId) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Transction Successful"),
    content: Text("Transaction ID: \n" + txId),
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

txError(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Transction Failed"),
    content: Text("Something went wrong"),
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

Future<void> importWallet(BuildContext context) async {
  TextEditingController _textFieldController = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Import Wallet'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Enter Seed-Words"),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('Import'),
              onPressed: () {
                try { 
                  recoverWalletFromWords(_textFieldController.value.text);
                } on InvalidSeedException {
                  invalidSeedWords(context);
                }
              },
            ),
          ],
        );
      });
}

invalidSeedWords(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Invalid Seed Words"),
    content: Text("Make sure you typed your mnemonic phrase correctly."),
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
