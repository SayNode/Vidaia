import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vidaia/pages/profile_testing.dart';
import 'package:vidaia/utils/auth0.dart';
import 'package:vidaia/utils/globals.dart' as globals;

import '../utils/wallet.dart';
import 'home/home_page_loader.dart';
import 'login_testing.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
const AUTH0_DOMAIN = 'saynode.eu.auth0.com';
const AUTH0_CLIENT_ID = 'NtesFp8kbFYekf05rleULMSdBS5hEWRN';

const AUTH0_REDIRECT_URI = 'com.auth0.vidaia://login-callback';
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';

class Auth0TestPage extends StatefulWidget {
  Auth0TestPage();

  @override
  State<Auth0TestPage> createState() => _Auth0TestPageState();
}

class _Auth0TestPageState extends State<Auth0TestPage> {
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auth0 Test'),
      ),
      body: Center(
        child: globals.isBusy
            ? CircularProgressIndicator()
            : Login(loginAction, errorMessage),
      ),
    );
  }

  Future<void> loginAction() async {
    setState(() {
      globals.isBusy = true;
      errorMessage = '';
    });

    try {
      final AuthorizationTokenResponse? result =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(AUTH0_CLIENT_ID, AUTH0_REDIRECT_URI,
            issuer: 'https://$AUTH0_DOMAIN',
            scopes: ['openid', 'profile', 'offline_access'],
            promptValues: ['login']),
      );

      final idToken = parseIdToken(result!.idToken!);
      final profile = await getUserDetails(result.accessToken!);
      print('-------------------> '+json.encode(profile));
      var name = profile['name'];
      globals.user = """{
    "userId": "1",
    "displayName": "$name",
    "walletAdress": "0x0..."
}""";

      await secureStorage.write(
          key: 'refresh_token', value: result.refreshToken);

      setState(() {
        globals.isBusy = false;
        globals.isLoggedIn = true;
        globals.name = idToken['globals.name'];
        globals.picture = profile['globals.picture'];
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage2()),
      );
      if (!globals.mnemonicNoted) {
        showMnemonicAlert(context);
      }
    } catch (e, s) {
      print('login error: $e - stack: $s');

      setState(() {
        globals.isBusy = false;
        globals.isLoggedIn = false;
        errorMessage = e.toString();
      });
    }
  }

  @override
  void initState() {
    initAction();
    super.initState();
  }

  void initAction() async {
    final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
    if (storedRefreshToken == null) return;

    setState(() {
      globals.isBusy = true;
    });

    try {
      final response = await appAuth.token(TokenRequest(
        AUTH0_CLIENT_ID,
        AUTH0_REDIRECT_URI,
        issuer: AUTH0_ISSUER,
        refreshToken: storedRefreshToken,
      ));

      final idToken = parseIdToken(response!.idToken!);
      final profile = await getUserDetails(response.accessToken!);

      secureStorage.write(key: 'refresh_token', value: response.refreshToken);

      setState(() {
        globals.isBusy = false;
        globals.isLoggedIn = true;
        globals.name = idToken['globals.name'];
        globals.picture = profile['globals.picture'];
      });
    } catch (e, s) {
      print('error on refresh token: $e - stack: $s');
      logoutAction(context);
    }
  }
}
