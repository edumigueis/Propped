import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppBar() : preferredSize = Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: true,
      elevation: 0.0,
      actions: <Widget>[
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 23, 20, 0),
            child: Icon(Icons.shopping_basket, size: 30,color: Colors.black,)
        )
      ],
    );
  }
}