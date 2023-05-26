import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<void> storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    // await prefs.setString('userId', value);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
