import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModalFit extends StatelessWidget {
  const ModalFit({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('XXS'),
                leading: Icon(CupertinoIcons.minus_circled),
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                title: Text('XS'),
                leading: Icon(Icons.content_copy),
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                title: Text('S'),
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                title: Text('M'),
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                title: Text('L'),
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                title: Text('XL'),
                leading: Icon(CupertinoIcons.add),
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                title: Text('XXL'),
                leading: Icon(CupertinoIcons.add_circled),
                onTap: () => Navigator.of(context).pop(),
              )
            ],
          ),
        ));
  }
}