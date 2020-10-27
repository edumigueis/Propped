import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget{

  FilterItem({Key key, @required String filterName}):
      this.filter = filterName,
      super(key: key);

  String filter;

  @override
  Widget build(BuildContext context){
    return CupertinoPageScaffold(
        navigationBar:
        CupertinoNavigationBar(
          middle: Text(
              this.filter),
        ),
        child: Stack(
          fit: StackFit
              .expand,
          children: <
              Widget>[],
        ));
  }
}