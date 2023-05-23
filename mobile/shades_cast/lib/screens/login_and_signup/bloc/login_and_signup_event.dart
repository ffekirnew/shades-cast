part of 'login_and_signup_bloc.dart';

@immutable
abstract class LoginAndSignupEvent {}

class LoginSubmitButtonClicked extends LoginAndSignupEvent {
  final String email;
  final String password;
  final BuildContext context;

  LoginSubmitButtonClicked(
      {required this.email, required this.password, required this.context});
}

class SignupSubmitButtonClicked extends LoginAndSignupEvent {
  final String username;
  final String email;
  final String password1;
  final String password2;
  SignupSubmitButtonClicked(
      {required this.username,
      required this.email,
      required this.password1,
      required this.password2});
}

class ToSignupButtonClicked extends LoginAndSignupEvent {}

class ToLoginButtonClicked extends LoginAndSignupEvent {}
