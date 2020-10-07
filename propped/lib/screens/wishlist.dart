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
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.fromLTRB(7.5, 0, 7.5, 0),
            child: Column(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(7.5, 40.0, 7.5, 20.0),
                      child: Text(
                        "Wishlist",
                        style: TextStyle(
                            fontSize: 35.0,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(40, 40, 40, 1)),
                      ),
                    )),
                Expanded(
                  child: GridView.count(
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this produces 2 rows.
                    crossAxisCount: 2,
                    childAspectRatio: (itemWidth / itemHeight),
                    // Generate 100 widgets that display their index in the List.
                    children: List.generate(10, (index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(7.5, 0, 7.5, 15),
                          child: Column(children: <Widget>[
                        Container(
                            height: MediaQuery.of(context).size.height / 2.5,
                            width: MediaQuery.of(context).size.width / 2,
                            child: Image(
                              image: NetworkImage(
                                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                              fit: BoxFit.cover,
                            )),
                        Text(
                          'Item $index',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ]));
                    }),
                  ),
                )
              ],
            )));
  }
}
