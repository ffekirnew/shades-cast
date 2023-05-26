import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'BloC.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Favorites")),
        body: ListView.builder(
          itemBuilder: (Context, int index) {
            // make use of bloc
          },
        ));
  }
}
