import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/screens/product.dart';

class ErrorMsgWidget extends StatefulWidget {
  ErrorMsgWidget({Key key, @required this.title, @required this.message})
      : super(key: key);

  final String title;
  final String message;

  @override
  ErrorMsgWidgetState createState() => ErrorMsgWidgetState();
}

class ErrorMsgWidgetState extends State<ErrorMsgWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(this.widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(30, 30, 30, 1))),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(this.widget.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.normal,
                      color: Color.fromRGBO(30, 30, 30, 1))),
            ),
          ],
        ),
      ),
    );
  }
}
