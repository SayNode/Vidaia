import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vidaia/pages/auth0_testing_page.dart';

Map<String, dynamic> parseIdToken(String idToken) {
  final parts = idToken.split(r'.');
  assert(parts.length == 3);

  return jsonDecode(
      utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
}

Future<Map<String, dynamic>> getUserDetails(String accessToken) async {
    final url = Uri.parse('https://$AUTH0_DOMAIN/userinfo');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get user details');
    }
  }
