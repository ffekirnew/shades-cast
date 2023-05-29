import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'authService.dart';

class FunfactApiClient {
  AuthService authService = AuthService();
  FunfactApiClient();

  Future<dynamic>? getFunfact() async {
    final response = await http.get(Uri.parse("$api/api/v3/resources/facts/"));
    print(response.body);
    if (response.statusCode != 200) {
      throw ('cannot get funfact');
    }
    return json.decode(response.body);
  }

  Future<dynamic> addFunfact(dynamic funfact) async {
    String? token = await authService.getToken();
    if (token == null) {
      throw Exception("cannot get token");
    }

    Map<String, String> headers = {'Authorization': 'Token $token'};
    final response = await http.post(Uri.parse("$api/api/v3/resources/facts/"),
        body: funfact, headers: headers);

    if (response.statusCode != 201) {
      return null;
    }
    return json.decode(response.body);
  }
}
