part of 'login_and_signup_bloc.dart';

@immutable
abstract class LoginAndSignupState {}

class LoginAndSignupInitial extends LoginAndSignupState {}

class LoginState extends LoginAndSignupState {
  final successNote;
  final failureNote;
  final isLoading;

  LoginState(
      {this.successNote = false,
      this.failureNote = '',
      this.isLoading = false});
}

class SignupState extends LoginAndSignupState {
  final successNote;
  final failureNote;
  final isLoading;

  SignupState(
      {this.successNote = false,
      this.failureNote = '',
      this.isLoading = false});
}
