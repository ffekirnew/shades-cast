import 'package:flutter/material.dart';
import './screens/home/ui/home.dart';
import './screens/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './screens/login_and_signup/ui/login_and_signup.dart';
import './screens/login_and_signup/bloc/login_and_signup_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (BuildContext context) => LoginAndSignupBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    ),
  );
}
