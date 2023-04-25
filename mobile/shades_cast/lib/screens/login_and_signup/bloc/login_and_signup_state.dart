part of 'login_and_signup_bloc.dart';

@immutable
abstract class LoginAndSignupState {}

class LoginAndSignupInitial extends LoginAndSignupState {}

class LoginState extends LoginAndSignupState {
  LoginState() {
    print("hello");
  }
}

class SignupState extends LoginAndSignupState {}
