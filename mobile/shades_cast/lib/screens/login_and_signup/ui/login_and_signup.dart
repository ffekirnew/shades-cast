import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_and_signup_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginAndSignupBloc, LoginAndSignupState>(
      builder: (context, state) {
        if (state is SignupState) {
          return getPage(0, context);
        } else if (state is LoginAndSignupInitial) {
          return getPage(0, context);
        } else if (state is LoginState) {
          return getPage(1, context);
        } else {
          return getPage(0, context);
        }
      },
    );
  }
}

Widget getPage(int option, BuildContext context) {
  if (option == 1) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 50),
            SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Perform login functionality
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                // Perform login functionality
                BlocProvider.of<LoginAndSignupBloc>(context)
                    .add(ToSignupButtonClicked());
              },
              child: Text('Signup?'),
            )
          ],
        ),
      ),
    );
  } else {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 50),
            SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Perform login functionality
              },
              child: Text('Sign Up'),
            ),
            ElevatedButton(
              onPressed: () {
                // Perform login functionality
                BlocProvider.of<LoginAndSignupBloc>(context)
                    .add(ToLoginButtonClicked());
              },
              child: Text('Login?'),
            ),
          ],
        ),
      ),
    );
  }
}
