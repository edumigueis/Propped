import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/widgets/customAppBar.dart';

class MyShoppingBag extends StatefulWidget{
  @override
  _MyShoppingBagState createState() => _MyShoppingBagState();
}

class _MyShoppingBagState extends State<MyShoppingBag>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showArrow: true),
      body: Container(),
    );
  }
}
