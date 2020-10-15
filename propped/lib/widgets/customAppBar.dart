import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/screens/preference.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key key, @required bool showArrow})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        this.showArrow = showArrow,
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  final bool showArrow;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: widget.showArrow,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
        size: 30,
      ),
      backgroundColor: Colors.transparent,
      actions: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyPreference()),
          ),
          child: Container(
              child: Icon(Icons.shopping_basket),
              margin: const EdgeInsets.only(right: 10)),
        )
      ],
    );
  }
}
