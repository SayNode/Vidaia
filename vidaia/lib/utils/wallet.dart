import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:thor_devkit_dart/crypto/mnemonic.dart';
import 'package:thor_devkit_dart/crypto/secp256k1.dart';
import 'package:thor_devkit_dart/utils.dart';
import 'package:thor_devkit_dart/crypto/address.dart';
import 'package:thor_request_dart/connect.dart';
import 'package:thor_request_dart/contract.dart';
import 'package:thor_request_dart/wallet.dart';
import 'package:vidaia/utils/globals.dart' as global;

createNewWallet() async {
  //generate mnemonic phrase and save it on local device
  List<String> words = Mnemonic.generate();
  final storage = FlutterSecureStorage();
  await storage.write(key: "mnemonicPhrase", value: words.join(' '));

  //derive privat key from words and save it on local device
  var priv = Mnemonic.derivePrivateKey(words);
  global.address =
      Address.publicKeyToAddressString(derivePublicKeyFromBytes(priv, false));

  await storage.write(key: "privateKey", value: bytesToHex(priv));
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
  final priv =
      '68afea4a4d35f7555ac1d4c6b9e29199213410edfb534cb544a52301b98aa33f';
  await storage.write(key: "privateKey", value: priv);
}

recoverWalletFromWords(List<String> words) async {
  final storage = FlutterSecureStorage();
  await storage.write(key: "mnemonicPhrase", value: words.join(' '));

  var priv = Mnemonic.derivePrivateKey(words);
  await storage.write(key: "privateKey", value: bytesToHex(priv));
}

Future<Map> transferVidar(int value, String address, String url) async {
  final storage = FlutterSecureStorage();
  Connect connect = Connect(url);
  final String? priv = await storage.read(key: 'privateKey');
  Wallet wallet = Wallet(hexToBytes(priv!));
  var toVidar = BigInt.parse('DE0B6B3A7640000', radix: 16);

  BigInt vidar = BigInt.from(value) * toVidar;

  return await connect.transferToken(
      wallet, address, '0x6e21867DB6572756e778883E17e7595b7f363310', vidar);
}

Stream<BigInt> checkBalance() => Stream.periodic(Duration(seconds: 1))
    .asyncMap((_) => _getBalance(global.address!));

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
  Map a = await connect.call(address, contract, 'balanceOf', [address],
      '0x6e21867DB6572756e778883E17e7595b7f363310');
  var no0x = remove0x(a["data"]);
  var noLeadingZeros = no0x.replaceAll("^0+", "");
  var wei = BigInt.parse(noLeadingZeros, radix: 16);
  var devidor = BigInt.parse('DE0B6B3A7640000', radix: 16);
  var vidar = wei / devidor;

  return BigInt.from(vidar);
}
