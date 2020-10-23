import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/widgets/customAppBar.dart';

class MyCategories extends StatefulWidget {
  @override
  _MyCategoriesState createState() => _MyCategoriesState();
}

class _MyCategoriesState extends State<MyCategories> {
  List categories = ["Bags", "Sportswear", "Accessories"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(showArrow: true),
        body: Container(
          margin: EdgeInsets.only(top: 20),
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 60,
                  decoration: new BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1.0,
                              style: BorderStyle.solid,
                              color: Colors.black26))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          categories[index],
                          style: TextStyle(fontSize: 17),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromRGBO(30, 30, 30, 1),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}
