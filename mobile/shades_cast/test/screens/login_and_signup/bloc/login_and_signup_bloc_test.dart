import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:shades_cast/screens/login_and_signup/bloc/login_and_signup_bloc.dart';
import 'package:shades_cast/repository/user_repo.dart';
import 'package:flutter/material.dart';

class MockUserRepo extends Mock implements UserRepo {}

void main() {
  group('LoginAndSignupBloc', () {
    LoginAndSignupBloc loginAndSignupBloc = LoginAndSignupBloc();
    MockUserRepo mockUserRepo = MockUserRepo();

    setUp(() {
      mockUserRepo = MockUserRepo();
      loginAndSignupBloc = LoginAndSignupBloc();
    });

    tearDown(() {
      loginAndSignupBloc.close();
    });

    test('emits LoginState when ToLoginButtonClicked is added', () {
      final expectedStates = [
        LoginState(),
        LoginState(successNote: true),
        LoginState(failureNote: 'Login Failed. Try again'),
        LoginState(isLoading: true),
        LoginState(successNote: true, isLoading: true),
      ];

      blocTest<LoginAndSignupBloc, LoginAndSignupState>(
        'emits LoginState when ToLoginButtonClicked is added',
        build: () => loginAndSignupBloc,
        act: (bloc) => bloc.add(ToLoginButtonClicked()),
        expect: () => expectedStates,
      );
    });

    test(
        'emits LoginState with failureNote when LoginSubmitButtonClicked fails',
        () async {
      final email = 'test@example.com';
      final password = 'password';
      final BuildContext context;

      when(mockUserRepo.LoginUser(email: email, password: password))
          .thenAnswer((_) async => 'Failure');

      final expectedStates = [
        LoginState(isLoading: true),
        LoginState(failureNote: 'Login Failed. Try again'),
      ];

      blocTest<LoginAndSignupBloc, LoginAndSignupState>(
        'emits LoginState with failureNote when LoginSubmitButtonClicked fails',
        build: () => loginAndSignupBloc,
        act: (bloc) => bloc.add(LoginSubmitButtonClicked(
            email: email, password: password, context: context)),
        expect: () => expectedStates,
      );

      verify(mockUserRepo.LoginUser(email: email, password: password))
          .called(1);
    });
  });
}
