import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Footer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(border: Border(top: BorderSide(), bottom: BorderSide())),
          child: Row(children: [
            Column(
              children: [
                Icon(Icons.phone),
                Text("Call Us")
              ],
            ),
            Column(
              children: [
                Icon(Icons.email),
                Text("Email Us")
              ],
            )
          ],),
        )
      ],
    );
    
  }
}
