import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/screens/categories.dart';
import 'package:propped/screens/home.dart';
import 'package:propped/widgets/customAppBar.dart';
import 'package:propped/widgets/menu.dart';

class MySearch extends StatefulWidget {
  @override
  _Search createState() => _Search();
}

class _Search extends State<MySearch> {
  var _controller = TextEditingController();
  var _visibleRemove = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        showArrow: false,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 100.0, 0.0, 30.0),
            child: Text(
              "Search",
              style: TextStyle(
                  fontSize: 35.0,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(40, 40, 40, 1)),
            ),
          ),
          Theme(
            data: ThemeData(primaryColor: Color.fromRGBO(30, 30, 30, 1)),
            isMaterialAppTheme: false,
            child: TextField(
              onSubmitted: (String key) => {
                if (key.trim() == "") {} else {debugPrint(key)}
              },
              onChanged: (String str) => {
                if (str == "")
                  setState(() => {_visibleRemove = Colors.transparent})
                else
                  setState(
                      () => {_visibleRemove = Color.fromRGBO(30, 30, 30, 1)})
              },
              controller: _controller,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => {
                      _controller.clear(),
                      setState(() => {_visibleRemove = Colors.transparent})
                    },
                    icon: Icon(
                      Icons.clear,
                      color: _visibleRemove,
                    ),
                  ),
                  prefixIcon: Icon(Icons.search),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(30, 30, 30, 1), width: 4.0),
                      borderRadius: BorderRadius.zero),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(30, 30, 30, 1), width: 3.0),
                      borderRadius: BorderRadius.zero),
                  hintText: 'Products, designers and all'),
            ),
          ),
          GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyCategories()),
              )
            },
            child: Container(
              margin: EdgeInsets.only(top: 25),
              height: 90,
              decoration: new BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1.0,
                          style: BorderStyle.solid,
                          color: Colors.black26))),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Categories",
                      style: TextStyle(
                          fontSize: 21.0,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(40, 40, 40, 1)),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromRGBO(30, 30, 30, 1),
                    )
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
              onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHome()),
                    )
                  },
              child: Container(
                height: 70,
                decoration: new BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1.0,
                            style: BorderStyle.solid,
                            color: Colors.black26))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Designers",
                        style: TextStyle(
                            fontSize: 21.0,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(40, 40, 40, 1)),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromRGBO(30, 30, 30, 1),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
      bottomNavigationBar: MyMenu(
        meIcon: CupertinoIcons.person,
        searchIcon: CupertinoIcons.search,
        homeIcon: Icons.home,
        wishlistIcon: Icons.star_border,
      ),
    );
  }
}
