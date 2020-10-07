import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyStore extends StatefulWidget {
  MyStore({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyStoreState createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
        child: Column(
            children: <Widget>[
              
            ],
        ),
      ),
    );
  }
}
