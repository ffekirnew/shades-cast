import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain_layer/user.dart';
import 'constants.dart';
import 'authService.dart';
import 'package:path/path.dart' as path;

class UserApiClient {
  UserApiClient();
  final AuthService authService = AuthService();

  Future<String> signUp({
    required String username,
    required String email,
    required String password1,
    required String password2,
  }) async {
    final url = 'https://fikernewapi.pythonanywhere.com/api/auth/signup/';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password1': password1,
        'password2': password2,
        'email': email,
      }),
    );

    if (response.statusCode != 204) {
      print(response.statusCode);
      Map resData = jsonDecode(response.body);
      print("error here");

      if (resData.containsKey('username')) {
        return 'Invalid Username';
      } else if (resData.containsKey('email')) {
        return 'Invalid Email';
      } else if (resData.containsKey('password1')) {
        return resData['password1'][0];
      } else if (resData.containsKey('password2')) {
        return resData['password2'][0];
      } else if (resData.containsKey('non_field_errors')) {
        return resData['non_field_errors'][0];
      } else {
        return "Unknown error happened. Try again.";
      }
    } else {
      return 'Success';
    }
  }

  Future<String> login(
      {required String email, required String password}) async {
    final url = '$api/api/auth/login/';

    print('got here');
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['key'];
      authService.storeToken(token);

      return token;
    } else {
      throw Exception('Failed to login user with email $email');
    }
  }

  ////////////////////////////////////////////////
  ///
  ///
  ///
  Future? updateUser(User newUser) async {
    String? token = await authService.getToken();
    if (token == null) {
      throw Exception("cannot get token");
    }
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response =
        await http.put(Uri.parse("$api/api/v2/users/${newUser.id}/"));
    if (response.statusCode != 200) {
      throw Exception("cannot update user");
    } else {
      return jsonDecode(response.body);
    }
  }

  ////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  Future<dynamic> userDetails() async {
    String? token = await authService.getToken();
    if (token == null) {
      throw Exception("cannot get token");
    }
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(Uri.parse('$api/api/v2/users/myaccount'),
        headers: headers);
    if (response.statusCode != 200) {
      throw Exception("cannot update user");
    } else {
      return jsonDecode(response.body);
    }
  }
}
