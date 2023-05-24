import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'authService.dart';

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
    final url = 'https://fikernewapi.pythonanywhere.com/api/auth/login/';

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
}



// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'constants.dart';

// class UserApiClient {
//   UserApiClient();

//   Future<void> signUp({required String email, required String password}) async {
//     final url = '$api/api/auth/signup';

//     final response = await http.post(
//       Uri.parse(url),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'email': email, 'password': password}),
//     );

//     if (response.statusCode != 201) {
//       throw Exception('Failed to sign up user with email $email');
//     }
//   }

//   Future<String> login(
//       {required String email, required String password}) async {
//     final url = '$api/api/auth/login';

//     final response = await http.post(
//       Uri.parse(url),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'email': email, 'password': password}),
//     );

//     if (response.statusCode == 200) {
//       final responseBody = jsonDecode(response.body);
//       final token = responseBody['key'];
//       return token;
//     } else {
//       throw Exception('Failed to login user with email $email');
//     }
//   }
// }
