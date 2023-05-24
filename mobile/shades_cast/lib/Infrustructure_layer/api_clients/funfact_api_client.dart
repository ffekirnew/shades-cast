import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';

class FunfactApiClient {
  FunfactApiClient();

  Future<dynamic>? getFunfact() async {
    final response = await http.get(Uri.parse("$api/v2/fact"));
    if (response.statusCode != 200) {
      return null;
    }
    return json.decode(response.body);
  }
}
