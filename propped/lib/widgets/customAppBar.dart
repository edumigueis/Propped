import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/screens/cart.dart';
import 'package:propped/screens/preference.dart';
import 'package:propped/screens/store.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key key, String title, @required bool showArrow})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        this.showArrow = showArrow,
        this.title = title,
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0
  final String title;
  final bool showArrow;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: () {
        if (widget.title != null) {
          if (widget.title.trim() != "") {
            debugPrint(widget.title);
            return Text(
              widget.title,
              style: TextStyle(
                  color: Color.fromRGBO(30, 30, 30, 1),
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w500),
            );
          } else
            return Text("");
        }
      }(),
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
            MaterialPageRoute(builder: (context) => MyShoppingBag()),
          ),
          child: Container(
              child: Icon(Icons.shopping_basket),
              margin: const EdgeInsets.only(right: 10)),
        )
      ],
    );
  }
}
