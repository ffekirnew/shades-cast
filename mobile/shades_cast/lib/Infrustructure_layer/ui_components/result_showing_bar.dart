import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ResultShowingBar extends StatelessWidget {
  final state;
  final isSignup;
  const ResultShowingBar({required this.state, required this.isSignup});

  @override
  Widget build(BuildContext context) {
    if (isSignup & state.successNote) {
      return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.green)),
        margin: EdgeInsets.only(bottom: 25, left: 20, right: 20, top: 20),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Text(
            "Signup was successfull. Log in to get started.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green,
              fontSize: 14,
            ),
          ),
        ),
      );
    } else if ((state.failureNote != 'Success') & (state.failureNote != '')) {
      return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        margin: EdgeInsets.only(bottom: 25, left: 20, right: 20, top: 20),
        child: Container(
          height: 47,
          child: Center(
            child: Text(
              isSignup ? state.failureNote : "Login Failed",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontSize: 14,
              ),
            ),
          ),
        ),
      );
    } else if (state.isLoading) {
      return Container(
        margin: EdgeInsets.only(bottom: 25, left: 20, right: 20, top: 20),
        child: Center(
          child: SpinKitCircle(
            color: Color.fromARGB(255, 202, 247, 255),
            size: 50.0,
          ),
        ),
      );
    }
    return Container(padding: EdgeInsets.only(bottom: 37), child: Text(''));
  }
}
