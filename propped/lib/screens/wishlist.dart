import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/models/Favorite.dart';
import 'package:propped/models/Product.dart';
import 'package:propped/utils/Constants.dart';
import 'package:propped/widgets/customAppBar.dart';
import 'package:propped/widgets/menu.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MyWishlist extends StatefulWidget {
  MyWishlist({Key key}) : super(key: key);

  @override
  _MyWishlistState createState() => _MyWishlistState();
}

class _MyWishlistState extends State<MyWishlist> {
  final idUser = 27;

  Future<List<Favorite>> fetchFavorites() async {
    final response =
    await http.get('http://' + Constants.serverIP + '/favorites/user/'+ this.idUser.toString());

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values = new List<dynamic>();
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            favs.add(Favorite.fromJson(map));
          }
        }
      }
      await fetchProducts(favs);
      return favs;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load wishlist');
    }
  }

  Future<List<Product>> fetchProducts(List<Favorite> favorites) async {
    for(int f = 0; f < favorites.length; f++){
      final response =
      await http.get('http://' + Constants.serverIP + '/products/'+ favorites[f].product.toString());

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        List<dynamic> values = new List<dynamic>();
        values = json.decode(response.body);
        if (values.length > 0) {
          for (int i = 0; i < values.length; i++) {
            if (values[i] != null) {
              Map<String, dynamic> map = values[i];
              products.add(Product.fromJson(map));
            }
          }
        }
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load post');
      }
    }
    if (this.mounted) setState(() {});
    return products;
  }

  List<Product> products = new List<Product>();
  List<Favorite> favs = new List<Favorite>();

  @override
  void initState(){
    super.initState();
    fetchFavorites();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*Here i'm not worrying about menu or notification bar height,
    because the grid parent has vertical scroll behaviour.*/
    final double itemHeight = size.height / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(showArrow: false),
      body: Padding(
          padding: EdgeInsets.fromLTRB(7.5, 50, 7.5, 0),
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
                                  height:
                                      MediaQuery.of(context).size.height / 3,
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
          )),
      bottomNavigationBar: MyMenu(
        meIcon: CupertinoIcons.person,
        searchIcon: CupertinoIcons.search,
        homeIcon: CupertinoIcons.home,
        wishlistIcon: Icons.star,
      ),
    );
  }
}
