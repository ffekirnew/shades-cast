import 'package:flutter/material.dart';

class RegularTextField extends StatelessWidget {
  final icon;
  RegularTextField({this.hintText = '', this.controller, this.icon}) {}
  final controller;
  final hintText;

  @override
  Widget build(BuildContext context) {
    IconData curIcon = Icons.person;

    if (this.hintText.contains('Name')) {
      curIcon = Icons.person;
    } else if ((this.hintText.contains('Email'))) {
      curIcon = Icons.email;
    } else if (this.hintText.contains('Password')) {
      curIcon = Icons.key;
      if (this.hintText.contains('Confirm')) {
        curIcon = Icons.verified_user;
      }
    }

    return Container(
      child: TextField(
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(55, 255, 255, 255))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(55, 255, 255, 255))),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 5, style: BorderStyle.solid),
          ),
          hintStyle: TextStyle(color: Color.fromARGB(255, 152, 152, 152)),
          prefixIconColor: Color.fromARGB(155, 255, 255, 255),
          prefixIcon: Icon(curIcon),
          hintText: hintText,
        ),
      ),
    );
  }
}
