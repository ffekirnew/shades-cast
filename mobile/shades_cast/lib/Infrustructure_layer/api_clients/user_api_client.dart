import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';

class UserApiClient {
  UserApiClient();

  Future<void> signUp({required String email, required String password}) async {
    final url = '$api/api/auth/signup';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to sign up user with email $email');
    }
  }

  Future<String> login(
      {required String email, required String password}) async {
    final url = '$api/api/auth/login';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['key'];
      return token;
    } else {
      throw Exception('Failed to login user with email $email');
    }
  }
}
