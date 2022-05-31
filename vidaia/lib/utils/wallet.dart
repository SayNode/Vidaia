import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:thor_devkit_dart/crypto/mnemonic.dart';
import 'package:thor_devkit_dart/crypto/secp256k1.dart';
import 'package:thor_devkit_dart/utils.dart';
import 'package:thor_devkit_dart/crypto/address.dart';
import 'package:thor_request_dart/connect.dart';
import 'package:thor_request_dart/contract.dart';
import 'package:thor_request_dart/wallet.dart';
import 'package:vidaia/utils/globals.dart' as global;

import 'exceptions.dart';

createNewWallet() async {
  //generate mnemonic phrase and save it on local device
  List<String> words = Mnemonic.generate();
  final storage = FlutterSecureStorage();
  await storage.write(key: "mnemonicPhrase", value: words.join(' '));

  //derive privat key from words and save it on local device
  var priv = Mnemonic.derivePrivateKey(words);
  global.address = Address.publicKeyToAddressString(derivePublicKeyFromBytes(priv, false));

  await storage.write(key: "privateKey", value: bytesToHex(priv));

  return global.address;
}

//TODO: remove this for release
Future<String?> getpriv() async {
  final storage = FlutterSecureStorage();
  final String? priv = await storage.read(key: 'privateKey');
  return priv;
}

//TODO: remove this for release
setPriv() async {
  final storage = FlutterSecureStorage();
  final priv = '68afea4a4d35f7555ac1d4c6b9e29199213410edfb534cb544a52301b98aa33f';
  await storage.write(key: "privateKey", value: priv);
}

recoverWalletFromWords(String words) async {
  if (!Mnemonic.validate(words.split(' '))) {
    throw InvalidSeedException('Invalid Mnemonic phrase');
  }
  final storage = FlutterSecureStorage();
  await storage.write(key: "mnemonicPhrase", value: words);

  var priv = Mnemonic.derivePrivateKey(words.split(' '));
  await storage.write(key: "privateKey", value: bytesToHex(priv));
}

Future<String> getWords() async {
  final storage = FlutterSecureStorage();
  var out = await storage.read(key: "mnemonicPhrase");
  return out.toString();
}

getWordButtons() async {
  final storage = FlutterSecureStorage();
  var words = await storage.read(key: "mnemonicPhrase");
  List<TextButton> wordButtons = [];
  List<String> wordsList = words!.split(" ");
  for (var word in wordsList) {
    wordButtons.add(TextButton(onPressed: null, child: Text(word)));
  }

  return wordButtons;
}

Future<Map> transferVidar(int value, String address, String url) async {
  final storage = FlutterSecureStorage();
  Connect connect = Connect(url);
  final String? priv = await storage.read(key: 'privateKey');
  Wallet wallet = Wallet(hexToBytes(priv!));
  var toVidar = BigInt.parse('DE0B6B3A7640000', radix: 16);

  BigInt vidar = BigInt.from(value) * toVidar;

  return await connect.transferToken(wallet, address, '0x6e21867DB6572756e778883E17e7595b7f363310', vidar);
}

Stream<BigInt> checkBalance() => Stream.periodic(Duration(seconds: 1)).asyncMap((_) => _getBalance(global.address!));

Future<BigInt> _getBalance(String address) async {
  Connect connect = Connect('https://testnet.veblocks.net');

  String jString = """{
  "abi": [
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "_owner",
          "type": "address"
        }
      ],
      "name": "balanceOf",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "balance",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    }
  ]
}""";

  Map contractMeta = json.decode(jString);
  Contract contract = Contract(contractMeta);
  Map a = await connect.call(address, contract, 'balanceOf', [address], '0x6e21867DB6572756e778883E17e7595b7f363310');
  var no0x = remove0x(a["data"]);
  var noLeadingZeros = no0x.replaceAll("^0+", "");
  var wei = BigInt.parse(noLeadingZeros, radix: 16);
  var devidor = BigInt.parse('DE0B6B3A7640000', radix: 16);
  var vidar = wei / devidor;

  return BigInt.from(vidar);
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

Future<void> importWallet(BuildContext context) async {
  TextEditingController _textFieldController = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('TextField in Dialog'),
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
