import 'dart:typed_data';

import 'package:thor_request_dart/wallet.dart';

String? address = '0x00bab3d8de4ebbefb07d53b1ff8c0f2434bd616d';

//TODO: Change this once server api is implemented
String? username;
String? password;
bool loginStatus = false;

List<String>? mnemonicPhrase;
Uint8List? privateKey;
Wallet? wallet;
String? qrCode;

bool mnemonicNoted = false;
String token = '';

//auth0
bool isBusy = false;
bool isLoggedIn = false;
String? name;
String? picture;


//priv c337cf0b3c7c3e4b7f5480b985724e0f221120554459b5c247870d2789726089
//address 0x17ACC76e4685AEA9d574705163E871b83e36697f
