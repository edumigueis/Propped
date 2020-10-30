import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/widgets/customAppBar.dart';
import 'package:propped/widgets/menu.dart';

class MySearchResult extends StatefulWidget {
  MySearchResult({Key key, @required String keyword})
      : this.keyword = keyword,
        super(key: key);

  final String keyword;

  @override
  _SearchResult createState() => _SearchResult();
}

class _SearchResult extends State<MySearchResult> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*Here i'm not worrying about menu or notification bar height,
    because the grid parent has vertical scroll behaviour.*/
    final double itemHeight = size.height / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        showArrow: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(7.5, 50, 7.5, 0),
        child: Column(
          children: <Widget>[
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(7.5, 40.0, 7.5, 20.0),
                  child: Text(
                        () {
                        return "Category";
                    }(),
                    style: TextStyle(
                        fontSize: 35.0,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(40, 40, 40, 1)),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "1201 items found",
                    style: TextStyle(
                        color: Color.fromRGBO(30, 30, 30, 1), fontSize: 16),
                  ),
                  OutlinedButton(
                    onPressed: () => {},
                    child: Row(
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(
                          Icons.reorder_rounded,
                          color: Color.fromRGBO(30, 30, 30, 1),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                          child: Text(
                            "Refine",
                            style: TextStyle(
                                color: Color.fromRGBO(30, 30, 30, 1),
                                fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.only(top: 20),
                physics: new BouncingScrollPhysics(),
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeight),
                // Generate 100 widgets that display their index in the List.
                children: List.generate(10, (index) {
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(7.5, 0, 7.5, 15),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                height: MediaQuery.of(context).size.height / 3,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      child: Image(
                                        image: NetworkImage(
                                            'https://cdn-images.farfetch-contents.com/15/23/22/29/15232229_29297818_1000.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: new Icon(Icons.star, size: 30),
                                    )
                                  ],
                                )),
                            Text('Martine Rose',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(120, 120, 120, 1)),
                                textAlign: TextAlign.center),
                            Text('Colorblock Pants',
                                style: TextStyle(
                                    fontSize: 19.0,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(40, 40, 40, 1)),
                                textAlign: TextAlign.center),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: Text('USD 1200',
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(40, 40, 40, 1)),
                                  textAlign: TextAlign.center),
                            )
                          ]));
                }),
              ),
            )
          ],
        ),
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
