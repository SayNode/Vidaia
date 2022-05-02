import 'package:thor_devkit_dart/crypto/keystore.dart';
import 'package:thor_devkit_dart/crypto/mnemonic.dart';
import 'package:thor_request_dart/connect.dart';
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


transferVidar(int value, String address, String url) {
  assert(global.wallet != null);
  Connect connect = Connect(url);
  connect.transferToken(global.wallet!, address, 'tokenContractAddress', BigInt.from(value));

}
