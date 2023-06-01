import 'package:shades_cast/Infrustructure_layer/api_clients/user_api_client.dart';

import '../domain_layer/user.dart';

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

  ////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  Future<User> getDetails() async {
    UserApiClient user = UserApiClient();

    final details = await user.userDetails();
    User current_user = User.fromMap(details);
    return current_user;
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

  ////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  Future<User> getUserDetail() async {
    UserApiClient user = UserApiClient();
    final result = await user.userDetails();
    print('user got called');
    print(User.fromMap(result));
    User current_user = User.fromMap(result);

    return current_user;
  }

  ////////////////////////////////////////////////////////////////
  ///
  ///
  Future<void> updateUser(dynamic userDetail) async {
    UserApiClient user = UserApiClient();
    try {
      print('in user repo to update user');
      final result = await user.updateUser(userDetail);
      print('user succuessfully updated');
    } catch (er) {
      print(er);
      throw ('update failed in user repo');
    }
  }

  ////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  Future<void> updateProfile(dynamic profile) async {
    UserApiClient user = UserApiClient();
    try {
      print('in user repo to update user');
      final result = await user.updateUser(profile);
      print('user succuessfully updated');
    } catch (er) {
      print(er);
      throw ('update failed in user repo');
    }
  }
}

// dont forget to clean it up by removing the creation of service out of the repo
