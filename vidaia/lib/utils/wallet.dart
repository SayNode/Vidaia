import 'dart:convert';
import 'dart:io';

import 'package:thor_devkit_dart/crypto/mnemonic.dart';
import 'package:thor_devkit_dart/utils.dart';
import 'package:thor_request_dart/connect.dart';
import 'package:thor_request_dart/contract.dart';
import 'package:thor_request_dart/wallet.dart';
import 'package:vidaia/utils/globals.dart' as global;

//TODO: change this to a secure save method for the words nd the key
createNewWallet() {
  assert(global.mnemonicPhrase == null);
  assert(global.privateKey == null);

  //generate mnemonic phrase and save it on local device
  List<String> words = Mnemonic.generate();
  global.mnemonicPhrase = words;

  //derive privat key from words and save it on local device
  var priv = Mnemonic.derivePrivateKey(words);

  //TODO: check if priv really needs to be saved
  global.privateKey = priv;
  global.wallet = Wallet(priv);
}

//TODO: change this to a secure save method for the words nd the key
recoverWalletFromWords(List<String> words) {
  assert(global.mnemonicPhrase == null);
  assert(global.privateKey == null);
  assert(global.wallet == null);

  //save mnemonic phrase  on local device
  global.mnemonicPhrase = words;

  //derive privat key from words and save it on local device
  var priv = Mnemonic.derivePrivateKey(words);
  global.privateKey = priv;
}

Future<Map> transferVidar(int value, String address, String url) {
  assert(global.wallet != null);
  Connect connect = Connect(url);
  //TODO: replace 'tokenContractAddress' with the address for vidar
  return connect.transferToken(
      global.wallet!, address, 'tokenContractAddress', BigInt.from(value));
}

Stream<double> checkBalance() => Stream.periodic(Duration(seconds: 1))
    .asyncMap((_) => _getBalance(global.address!));

Future<double> _getBalance(String address) async {
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
  Map a = await connect.call(address, contract, 'balanceOf', [address],
      '0x6e21867DB6572756e778883E17e7595b7f363310');
  var no0x = remove0x(a["data"]);
  var noLeadingZeros = no0x.replaceAll("^0+", "");
  var wei = BigInt.parse(noLeadingZeros, radix: 16);
  var devidor = BigInt.parse('DE0B6B3A7640000', radix: 16);
  var vidar = wei / devidor;

  return vidar;
}
