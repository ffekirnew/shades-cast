import 'package:shades_cast/Infrustructure_layer/api_clients/user_api_client.dart';

class UserRepo {
  Future<String> LoginUser(
      {required String email, required String password}) async {
    UserApiClient user = UserApiClient();

    // String res = await service.login(email: email, password: password);
    try {
      print(email);
      print(password);
      final res = await user.login(email: email, password: password);
    } catch (e) {
      print("Error on logging");
      print(e);
      return 'Failure';
    }
    print("Success");
    return 'Success';
  }

  Future<String> SignupUser({
    required String username,
    required String email,
    required String password1,
    required String password2,
  }) async {
    UserApiClient user = UserApiClient();

    try {
      final res = await user.signUp(
          username: username,
          email: email,
          password1: password1,
          password2: password2);

      return res;
    } catch (e) {
      print('error occured');
      print(e);
      return 'Failure';
    }
  }
}

// dont forget to clean it up by removing the creation of service out of the repo