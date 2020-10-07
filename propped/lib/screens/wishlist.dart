import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyWishlist extends StatefulWidget {
  MyWishlist({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyWishlistState createState() => _MyWishlistState();
}

class _MyWishlistState extends State<MyWishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40.0, 0, 20.0),
                    child: Text(
                      "Wishlist",
                      style: TextStyle(
                          fontSize: 35.0,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(40, 40, 40, 1)),
                    ),
                  )
                ),

                Expanded(
                  child: GridView.count(
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this produces 2 rows.
                    crossAxisCount: 2,
                    // Generate 100 widgets that display their index in the List.
                    children: List.generate(100, (index) {
                      return Center(
                        child: Text(
                          'Item $index',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      );
                    }),
                  ),
                )
              ],
            )));
  }
}
