import 'dart:typed_data';

import 'package:thor_request_dart/wallet.dart';

bool loginStatus = false;

List<String>? mnemonicPhrase;
Uint8List? privateKey;
Wallet? wallet;
String? address = '0x17ACC76e4685AEA9d574705163E871b83e36697f';