import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shades_cast/repository/user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_and_signup_event.dart';
part 'login_and_signup_state.dart';

void updateLoginStatus() async {
  print('here to update login');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
  final res = await prefs.getBool('isLoggedIn');
  print('login updated');
  print(res);
}

class LoginAndSignupBloc
    extends Bloc<LoginAndSignupEvent, LoginAndSignupState> {
  LoginAndSignupBloc() : super(LoginAndSignupInitial()) {
    on<LoginAndSignupEvent>((event, emit) async {
      emit(LoginState(isLoading: true));

      if (event is ToLoginButtonClicked) {
        emit(LoginState());
      } else if (event is LoginSubmitButtonClicked) {
        UserRepo user = UserRepo();
        String email = event.email;
        String password = event.password;
        String res = await user.LoginUser(email: email, password: password);
        if (res == "Failure") {
          emit(LoginState(failureNote: 'Login Failed. Try again'));
        } else if (res == "Success") {
          updateLoginStatus();
          Navigator.pushReplacementNamed(event.context, '/home');
        } else {
          emit(LoginState());
        }
      } else if (event is SignupSubmitButtonClicked) {
        emit(SignupState(isLoading: true));
        UserRepo user = UserRepo();

        String username = event.username;
        String email = event.email;
        String password1 = event.password1;
        String password2 = event.password2;
        String res = await user.SignupUser(
            username: username,
            email: email,
            password1: password1,
            password2: password2);
        if (res == "Failure") {
          emit(SignupState(failureNote: 'Unknown Error Occured'));
        } else if (res == "Success") {
          emit(SignupState(successNote: true));
        } else {
          emit(SignupState(failureNote: res));
        }
      } else if (event is ToSignupButtonClicked) {
        emit(SignupState());
      }
    });
  }
}
