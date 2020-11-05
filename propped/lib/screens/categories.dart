import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/screens/subcategorie.dart';
import 'package:propped/models/Category.dart';
import 'package:propped/utils/Constants.dart';
import 'package:propped/widgets/customAppBar.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MyCategories extends StatefulWidget {
  MyCategories({Key key}) : super(key: key);

  @override
  _MyCategoriesState createState() => _MyCategoriesState();
}

class _MyCategoriesState extends State<MyCategories> {
  Future<List<Category>> fetchCategory() async {
    final response =
        await http.get('http://' + Constants.serverIP + '/categories');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values = new List<dynamic>();
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            categories.add(Category.fromJson(map));
          }
        }
      }
      if (this.mounted) setState(() {});
      return categories;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  List<Category> categories = new List<Category>();

  @override
  void initState() {
    super.initState();
    fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("building");
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
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Subcategories(
                                          category: categories[index])),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
