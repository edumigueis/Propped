import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CustomAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
        "",
        style: TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0.0);
  }
}