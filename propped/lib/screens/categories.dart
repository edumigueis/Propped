import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/screens/subcategorie.dart';
import 'package:propped/utils/Category.dart';
import 'package:propped/widgets/customAppBar.dart';

class MyCategories extends StatefulWidget {
  @override
  _MyCategoriesState createState() => _MyCategoriesState();
}

class _MyCategoriesState extends State<MyCategories> {
  List categories = [new Category(1, "AJAAQIKlO" ,"Bags"), new Category(1, "AJAAQIKlO", "Bags"), new Category(1, "AJAAQIKlO", "Bags")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(showArrow: true),
        body: Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 70.0, 15, 20.0),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                        fontSize: 35.0,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(40, 40, 40, 1)),
                  ),
                ),
                ListView.builder(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 0),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Subcategories(category: categories[index])),
                          )
                        },
                          child: Container(
                        height: 60,
                        decoration: new BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                    color: Colors.black26))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                categories[index].getName(),
                                style: TextStyle(fontSize: 17),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Color.fromRGBO(30, 30, 30, 1),
                              )
                            ],
                          ),
                        ),
                      ));
                    }),
              ],
            )));
  }
}
