import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_and_signup_bloc.dart';
import 'package:shades_cast/Infrustructure_layer/ui_components/regular_text_field.dart';
import 'package:shades_cast/Infrustructure_layer/ui_components/result_showing_bar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginAndSignupBloc, LoginAndSignupState>(
        builder: (context, state) {
      if (state is LoginAndSignupInitial) {
        state = SignupState();
      }
      return getPage(context, state);
    });
  }
}

Widget getPage(BuildContext context, LoginAndSignupState state) {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  return SafeArea(
    child: Scaffold(
      backgroundColor: Color(0xFF09121C),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ResultShowingBar(
                    state: state, isSignup: !(state is LoginState)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Image(
                          image: AssetImage('Assets/images/podcast.png'),
                          width: 100,
                        ),
                      ),
                      SizedBox(height: 5),
                      (state is LoginState)
                          ? Text('')
                          : RegularTextField(
                              hintText: "Username",
                              controller: _nameController,
                            ),
                      SizedBox(height: 5),
                      RegularTextField(
                        hintText: (state is LoginState)
                            ? 'Email or Username'
                            : "Email",
                        controller: _emailController,
                      ),
                      SizedBox(height: 5),
                      RegularTextField(
                        disable: false,
                        hintText:
                            (state is LoginState) ? 'Password' : 'New Password',
                        controller: _passwordController,
                      ),
                      SizedBox(height: 5),
                      (state is LoginState)
                          ? Text('')
                          : RegularTextField(
                              disable: false,
                              hintText: "Confirm Password",
                              controller: _newPasswordController,
                            ),
                      SizedBox(height: 20),
                      Visibility(
                        visible: (state is LoginState),
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w200),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 13),
                          textColor: Colors.white,
                          color: Color.fromARGB(255, 0, 103, 222),
                          onPressed: () {
                            // Perform login functionality
                            if (state is LoginState) {
                              BlocProvider.of<LoginAndSignupBloc>(context).add(
                                LoginSubmitButtonClicked(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    context: context),
                              );
                            } else {
                              BlocProvider.of<LoginAndSignupBloc>(context).add(
                                  SignupSubmitButtonClicked(
                                      username: _nameController.text,
                                      email: _emailController.text,
                                      password1: _passwordController.text,
                                      password2: _newPasswordController.text));
                            }
                          },
                          child: (state is LoginState)
                              ? Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                )
                              : Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Perform login functionality
                          if (state is LoginState) {
                            BlocProvider.of<LoginAndSignupBloc>(context)
                                .add(ToSignupButtonClicked());
                          } else {
                            BlocProvider.of<LoginAndSignupBloc>(context)
                                .add(ToLoginButtonClicked());
                          }
                        },
                        child: (state is LoginState)
                            ? Text('Create a new account?')
                            : Text('Already have an account?'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
