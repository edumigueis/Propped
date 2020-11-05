import 'package:flutter/material.dart';
import 'package:propped/screens/searchCategoryResult.dart';
import 'package:propped/models/Category.dart';
import 'package:propped/models/Subcategory.dart';
import 'package:propped/utils/Constants.dart';
import 'package:propped/widgets/customAppBar.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Subcategories extends StatefulWidget {
  Subcategories({Key key, @required Category category})
      : this.cat = category,
        super(key: key);

  final Category cat;

  @override
  SubcategoriesState createState() => SubcategoriesState(cat);
}

class SubcategoriesState extends State<Subcategories> {
  Category cat;

  SubcategoriesState(Category cat) {
    this.cat = cat;
  }

  Future<List<Subcategory>> fetchSubCategories() async {
    final response = await http.get('http://' +
        Constants.serverIP +
        '/subcategories/category/' +
        this.cat.id.toString());

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values = new List<dynamic>();
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            subcategories.add(Subcategory.fromJson(map));
          }
        }
      }
      if (this.mounted) setState(() {});
      return subcategories;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load subcategories');
    }
  }

  final List<Subcategory> subcategories = new List<Subcategory>();

  @override
  void initState() {
    super.initState();
    fetchSubCategories();
  }

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
                    this.cat.name,
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
                    itemCount: subcategories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SearchCategoryResult(
                                              category: this.cat,
                                              subcategory:
                                                  this.subcategories[index])),
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
                                    subcategories[index].name,
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
