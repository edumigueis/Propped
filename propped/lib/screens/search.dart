import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/screens/categories.dart';
import 'package:propped/screens/designers.dart';
import 'package:propped/screens/home.dart';
import 'package:propped/screens/searchResult.dart';
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
        physics: new BouncingScrollPhysics(),
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
                if (key.trim() != "")
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MySearchResult(
                                keyword: key,
                              )),
                    )
                  }
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
                  filled: true,
                  fillColor: CupertinoColors.systemGrey5,
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
                          color: Color.fromRGBO(190, 190, 190, 1), width: 2.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  hintText: "Clothes, accessories and all"),
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
              margin: EdgeInsets.only(top: 20),
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
                      MaterialPageRoute(builder: (context) => MyDesigners()),
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
        searchIcon: Icons.search,
        homeIcon: CupertinoIcons.home,
        wishlistIcon: Icons.star_border,
      ),
    );
  }
}
