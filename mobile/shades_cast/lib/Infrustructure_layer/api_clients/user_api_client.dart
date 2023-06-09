import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

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
    final url = '$api/api/auth/signup/';

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
      Map resData = jsonDecode(response.body);

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

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['key'];
      authService.storeToken(token);
      // print('token' + token);
      // print(authService.getToken());
      return token;
    } else {
      throw Exception('Failed to login user with email $email');
    }
  }

  ////////////////////////////////////////////////
  ///
  ///
  ///
  Future<dynamic> updateUser(dynamic newUser) async {
    String? token = await authService.getToken();

    if (token == null) {
      throw Exception("cannot get token");
    }

    Map<String, String> headers = {'Authorization': 'Token $token'};

    if (newUser['cover_image'] == null) {
      newUser['cover_image'] = '';
    }

    final response = await http.patch(
      Uri.parse("$api/api/v3/my-account/"),
      body: newUser,
      headers: headers,
    );

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
  Future<dynamic> updateProfile(dynamic profile) async {
    File profile_pic = profile["profile_pic"];
    final AuthService authService = AuthService();

    String? token = await authService.getToken();
    // // print(profile_pic);
    // // print('got here');
    // String? token = await authService.getToken();

    // if (token == null) {}

    var stream = http.ByteStream(profile_pic.openRead());
    stream.cast();
    var length = await profile_pic.length();
    var uri = Uri.parse('$api/api/v3/my-account/profile');
    var request = http.MultipartRequest('PATCH', uri);
    // print('token : $token');

    request.headers['Authorization'] = 'Token $token';

    var multipartFile = http.MultipartFile(
      'photo',
      stream,
      length,
      filename: path.basename(profile_pic.path), // Use the original filename
    );
    request.files.add(multipartFile);
    request.fields['photo'] = path.basename(profile_pic.path);

    try {
      var response = await request.send();
      if (response.statusCode != 200) {
        // print("Error sending the file of user");
      } else {
        // print('Success');
      }
    } catch (e) {
      // print("Error: $e");
    }
  }

  ////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  Future<dynamic> userDetails() async {
    String? token = await authService.getToken();
    // print(token);
    if (token == null) {
      throw Exception("cannot get token");
    }
    Map<String, String> headers = {'Authorization': 'Token $token'};
    final response =
        await http.get(Uri.parse('$api/api/v3/my-account/'), headers: headers);

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
  ///
  Future<void> deleteUser(String userId) async {
    String? token = await authService.getToken();
    // // print(token);
    if (token == null) {
      throw Exception("cannot get token");
    }
    // print('here 1');
    Map<String, String> headers = {'Authorization': 'Token $token'};
    final response = await http.delete(Uri.parse('$api/api/v3/users/$userId/'),
        headers: headers);

    // print(response.body);

    if (response.statusCode != 204) {
      throw Exception("cannot update user");
    }
  }
}
