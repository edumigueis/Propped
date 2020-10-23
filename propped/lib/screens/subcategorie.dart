import 'package:flutter/material.dart';
import 'package:propped/utils/Category.dart';
import 'package:propped/widgets/customAppBar.dart';

class Subcategorie extends StatelessWidget{
  Subcategorie({Key key, @required Category categorie})
      : this.cat = categorie,
        super(key: key);

  Category cat;
  List subcategories = ["Backpacks", "Totes", "Trunks"];
    @override
    Widget build(BuildContext context) {
    return Scaffold(
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
                    this.cat.getName(),
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
                                    subcategories[index],
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