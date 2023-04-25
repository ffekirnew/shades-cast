part of 'login_and_signup_bloc.dart';

@immutable
abstract class LoginAndSignupEvent {}

class LoginSubmitButtonClicked extends LoginAndSignupEvent {}

class SignupSubmitButtonClicked extends LoginAndSignupEvent {}

class ToSignupButtonClicked extends LoginAndSignupEvent {}

class ToLoginButtonClicked extends LoginAndSignupEvent {}
