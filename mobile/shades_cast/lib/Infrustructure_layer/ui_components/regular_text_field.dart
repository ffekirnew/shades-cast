import 'package:flutter/material.dart';
import 'package:shades_cast/screens/settings/bloc/settings_bloc.dart';

class RegularTextField extends StatefulWidget {
  final icon;
  bool isHidden;
  bool disable;
  RegularTextField(
      {this.hintText = '',
      this.controller,
      this.icon,
      this.isHidden = true,
      this.disable = true}) {}
  final controller;
  final hintText;

  @override
  State<RegularTextField> createState() => _RegularTextFieldState();
}

class _RegularTextFieldState extends State<RegularTextField> {
  @override
  Widget build(BuildContext context) {
    IconData curIcon = Icons.person;

    if (this.widget.hintText.contains('Name')) {
      curIcon = Icons.person;
    } else if ((this.widget.hintText.contains('Email'))) {
      curIcon = Icons.email;
    } else if (this.widget.hintText.contains('Password')) {
      curIcon = Icons.key;
      if (this.widget.hintText.contains('Confirm')) {
        curIcon = Icons.verified_user;
      }
    }

    return Container(
      child: TextField(
        obscureText: widget.disable ? false : widget.isHidden,
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: widget.disable
              ? null
              : IconButton(
                  icon: Icon(
                    widget.isHidden ? Icons.visibility : Icons.visibility_off,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  onPressed: () {
                    setState(() {
                      widget.isHidden = !widget.isHidden;
                    });
                  },
                ),
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
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
