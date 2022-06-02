import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vidaia/helpers/constants.dart';
import 'package:vidaia/models/auth0_id_token.dart';
import 'package:vidaia/models/auth0_user.dart';
import 'package:pkce/pkce.dart';

class AuthService {
  Auth0User profile = Auth0User(nickname: '', name: '', email: '', picture: '', updatedAt: '', sub: '');
  Auth0IdToken? idToken;
  String? auth0AccessToken;
  bool isLoggedIn = false;

  static final AuthService instance = AuthService._internal();
  factory AuthService() => instance;
  AuthService._internal();

  final FlutterAppAuth appAuth = FlutterAppAuth();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<bool> init() async {
    final storedRefreshToken = await secureStorage.read(key: REFRESH_TOKEN_KEY);
    debugPrint('storedRefreshToken ' + storedRefreshToken.toString());

    if (storedRefreshToken == null) {
      return false;
    }

    try {
      final TokenResponse? result = await appAuth.token(
        TokenRequest(
          AUTH0_CLIENT_ID,
          AUTH0_REDIRECT_URI,
          issuer: AUTH0_ISSUER,
          refreshToken: storedRefreshToken,
        ),
      );
      final String setResult = await _setLocalVariables(result);
      isLoggedIn = true;
      debugPrint('isLoggedIn' + isLoggedIn.toString());
      return setResult == 'Success';
    } catch (e, s) {
      print('error on Refresh Token: $e - stack: $s');
      // logOut() possibly
      return false;
    }
  }

  Future<String> logout() async {
    await secureStorage.delete(key: REFRESH_TOKEN_KEY);
    final url = Uri.https(
      AUTH0_DOMAIN,
      '/v2/logout',
      {
        'client_id': AUTH0_CLIENT_ID,
        'federated': '',
        // 'returnTo': 'YOUR_RETURN_LOGOUT_URL'
      },
    );

    debugPrint('logout url: ' + url.toString());

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $auth0AccessToken'},
    );

    debugPrint('logout: ${response.request} ${response.statusCode} ${response.body}');

    return 'logout: ${response.request} ${response.statusCode} ${response.body}';
  }

  Future<String> login() async {
    try {
      final authorizationTokenRequest = AuthorizationTokenRequest(
        AUTH0_CLIENT_ID,
        AUTH0_REDIRECT_URI,
        issuer: AUTH0_ISSUER,
        scopes: ['openid', 'profile', 'email', 'offline_access', 'update:current_user_metadata', 'create:current_user_metadata'],
        promptValues: ['login'],

        /// possible values login, none, consent, select_account
      );

      final AuthorizationTokenResponse? result = await appAuth.authorizeAndExchangeCode(
        authorizationTokenRequest,
      );

      return await _setLocalVariables(result);
    } on PlatformException {
      return 'User has cancelled or no internet!';
    } catch (e) {
      return 'Unkown Error!';
    }
  }

  Auth0IdToken parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);

    final Map<String, dynamic> json = jsonDecode(
      utf8.decode(
        base64Url.decode(
          base64Url.normalize(parts[1]),
        ),
      ),
    );

    return Auth0IdToken.fromJson(json);
  }

  Future<Auth0User> getUserDetails(String accessToken) async {
    Auth0User auth0user;

    final url = Uri.https(
      AUTH0_DOMAIN,
      '/userinfo',
    );

    final responseAuth0UserInfo = await http.get(
      url,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    print('getUserDetails ${responseAuth0UserInfo.body}');

    if (responseAuth0UserInfo.statusCode == 200) {
      auth0user = Auth0User.fromJson(jsonDecode(responseAuth0UserInfo.body));
    } else {
      throw Exception('Failed to get user details');
    }

    if (responseAuth0UserInfo.statusCode == 200) {
      return auth0user;
    } else {
      throw Exception('Failed to get user details');
    }
  }

  Future<String> _setLocalVariables(result) async {
    final bool isValidResult = result != null && result.accessToken != null && result.idToken != null;

    if (isValidResult) {
      auth0AccessToken = result.accessToken;
      idToken = parseIdToken(result.idToken!);
      profile = await getUserDetails(result.accessToken!);
      if (result.refreshToken != null) {
        await secureStorage.write(
          key: REFRESH_TOKEN_KEY,
          value: result.refreshToken,
        );
        String? refreshTokenKeyFromStorage = await secureStorage.read(key: REFRESH_TOKEN_KEY);
        debugPrint('auth_service | REFRESH_TOKEN_KEY in storage is ' + refreshTokenKeyFromStorage!);
      }
      isLoggedIn = true;
      return 'Success';
    } else {
      return 'Something is Wrong!';
    }
  }

  Future<bool> updateUserWalletAddress(Auth0User auth0user) async {
    /// experiments to get the Management API token
    final managementApiTokenUrl = Uri.https(
      AUTH0_DOMAIN,
      '/oauth/token',
    );
    final managementAPIPostResponse = await http.post(managementApiTokenUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      'client_id': 'HjuGFyrQbhsSfRby4dBR0GqTTGF9ysh7',
      'client_secret': 'l1ofwHdiClPe5YK7ICKc6B97YPFCkCR7q68iLrPdk713rT8dTw4_-HXDbQEg-_72',
      'grant_type': 'client_credentials',
      'audience': 'https://dev-jp7b9rk6.us.auth0.com/api/v2/',
    });

    var body = jsonDecode(managementAPIPostResponse.body);
    var accessToken = body['access_token'];
    var scope = body['scope'];
    debugPrint('managementAPIPostResponse.body - ' + managementAPIPostResponse.body.toString());
    debugPrint('managementAPIPostResponse.scope - ' + scope.toString());

    ///

    final url = Uri.https(AUTH0_DOMAIN, '/api/v2/users/' + auth0user.id, {'audience': 'https://flutter.vidaia.ch/api/v2/'});

    debugPrint('update wallet request uri.https - ' + url.toString());
    debugPrint('update wallet auth0AccessToken -  $accessToken');
    debugPrint('update wallet request uri.https -  $idToken');

    final responseAuth0UserInfo = await http.patch(url,
        headers: {'Authorization': 'Bearer $accessToken', 'Content-Type': 'application/json'},
        body: jsonEncode({
          // "email": auth0user.email,
          "user_metadata": {"wallet_address": auth0user.walletAddress}
        }));
    if (responseAuth0UserInfo.statusCode == 200) {
      debugPrint('update wallet response 200');
      return true;
    } else {
      debugPrint('update wallet response ' + responseAuth0UserInfo.statusCode.toString());
      debugPrint('update wallet response body' + responseAuth0UserInfo.body);
      return false;
    }
  }
}
