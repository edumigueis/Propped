import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/screens/product.dart';
import 'package:propped/utils/pushAsPop.dart';

class ModalFit extends StatelessWidget {
  const ModalFit({Key key}) : super(key: key);

  _closeModal(BuildContext ctx, int index){
    /*Navigator.push(
      ctx,
      MaterialPageRoute(builder: (context) => MyProduct(selectedSize: index,)),
    );*/
    Navigator.pop(ctx);
  }
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
                onTap: () => _closeModal(context, 0),
              ),
              ListTile(
                title: Text('XS'),
                leading: Icon(Icons.content_copy),
                onTap: () => _closeModal(context, 1),
              ),
              ListTile(
                title: Text('S'),
                onTap: () => _closeModal(context, 2),
              ),
              ListTile(
                title: Text('M'),
                onTap: () => _closeModal(context, 3),
              ),
              ListTile(
                title: Text('L'),
                onTap: () => _closeModal(context, 4),
              ),
              ListTile(
                title: Text('XL'),
                leading: Icon(CupertinoIcons.add),
                onTap: () => _closeModal(context, 5),
              ),
              ListTile(
                title: Text('XXL'),
                leading: Icon(CupertinoIcons.add_circled),
                onTap: () => _closeModal(context, 6),
              )
            ],
          ),
        ));
  }
}