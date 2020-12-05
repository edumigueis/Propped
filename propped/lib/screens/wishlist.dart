import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:propped/models/Favorite.dart';
import 'package:propped/models/Image.dart';
import 'package:propped/models/Product.dart';
import 'package:propped/models/Store.dart';
import 'package:propped/utils/Constants.dart';
import 'package:propped/widgets/customAppBar.dart';
import 'package:propped/widgets/errorMsgWidget.dart';
import 'package:propped/widgets/menu.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:propped/widgets/productGridItem.dart';

class MyWishlist extends StatefulWidget {
  MyWishlist({Key key}) : super(key: key);

  @override
  _MyWishlistState createState() => _MyWishlistState();
}

class _MyWishlistState extends State<MyWishlist> {
  int idUser = 25;
  bool nothingFound = false;

  Future<List<Favorite>> fetchFavorites() async {
    this.idUser = await FlutterSession().get("id");
    debugPrint(idUser.toString());
    final response = await http.get('http://' +
        Constants.serverIP +
        '/favorites/user/' +
        this.idUser.toString());

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values = new List<dynamic>();
      values = json.decode(response.body);
      debugPrint(values.toString());
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
      setState(() {
        this.nothingFound = true;
      });
    }
  }

  Future<List<Product>> fetchProducts(List<Favorite> favorites) async {
    for (int f = 0; f < favorites.length; f++) {
      final response = await http.get('http://' +
          Constants.serverIP +
          '/products/id/' +
          favorites[f].product.toString());

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        List<dynamic> values = new List<dynamic>();
        values = json.decode(response.body);
        if (values.length > 0) {
          if (values[0] != null) {
            Map<String, dynamic> map = values[0];
            products.add(Product.fromJson(map));
          }
        }
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load products');
      }
    }
    await fetchStores(products);
    //await fetchImages(products);
    return products;
  }

  Future<List<ImageObj>> fetchImages(List<Product> prod) async {
    for (int f = 0; f < prod.length; f++) {
      final response = await http.get('http://' +
          Constants.serverIP +
          '/products/image/' +
          prod[f].id.toString());

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        List<dynamic> values = new List<dynamic>();
        values = json.decode(response.body);
        if (values.length > 0) {
          if (values[0] != null) {
            Map<String, dynamic> map = values[0];
            images.add(ImageObj.fromJson(map));
          }
        }
      } else {
        // If that call was not successful, throw an error.
        this.images.add(new ImageObj(url: "", idImage: -1, idProduct: -1));
      }
      await fetchImagesProp();
    }

    return images;
  }

  Future<List<ImageObj>> fetchImagesProp() async {
    for (int f = 0; f < images.length; f++) {
      final response = await http.get('http://' +
          Constants.serverIP +
          '/images/id/' +
          images[f].idImage.toString());

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        List<dynamic> values = new List<dynamic>();
        values = json.decode(response.body);

        if (values.length > 0) {
          if (values[0] != null) {
            Map<String, dynamic> map = values[0];
            this.images[f].url = map['photo_image'];
          }
        }
      } else {
        // If that call was not successful, throw an error.
        this.images[f].url =
            "https://icons-for-free.com/iconfiles/png/512/facebook+sad+emoji+sad+face+icon-1320166641720234915.png";
      }
    }
    return images;
  }

  Future<List<Store>> fetchStores(List<Product> prod) async {
    for (int f = 0; f < prod.length; f++) {
      final response = await http.get('http://' +
          Constants.serverIP +
          '/stores/' +
          prod[f].store.toString());

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        List<dynamic> values = new List<dynamic>();
        values = json.decode(response.body);
        if (values.length > 0) {
          if (values[0] != null) {
            Map<String, dynamic> map = values[0];
            stores.add(Store.fromJson(map));
          }
        }
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load products');
      }
    }
    await fetchImages(this.products);
    if (this.mounted) setState(() {});
    return stores;
  }

  List<Store> stores = new List<Store>();
  List<Product> products = new List<Product>();
  List<Favorite> favs = new List<Favorite>();
  List<ImageObj> images = new List<ImageObj>();

  @override
  void initState() {
    super.initState();
    this.nothingFound = false;
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
              Expanded(child: () {
                if (!this.nothingFound)
                  return GridView.count(
                    padding: const EdgeInsets.only(top: 20),
                    physics: new BouncingScrollPhysics(),
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this produces 2 rows.
                    crossAxisCount: 2,
                    childAspectRatio: (itemWidth / itemHeight),
                    // Generate 100 widgets that display their index in the List.
                    children: List.generate(products.length, (index) {
                      String img;
                      if (images == null || images.length == 0)
                        img = "a";
                      else if (images[index] == null)
                        img = "a";
                      else
                        img = images[index].url;
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 15),
                        child: ProductGridItem(
                          redirectCode: products[index].code,
                          image: img,
                          text1: stores[index].name,
                          text2: products[index].name,
                          text3: products[index].price.toString(),
                          isFavorite: true,
                          favorite: new Favorite(
                              product: this.products[index].id,
                              user: this.idUser),
                        ),
                      );
                    }),
                  );
                else {
                  return ErrorMsgWidget(
                      title: "Your wishlist is empty",
                      message:
                          "Star some products to save them in your wishlist and pick up where you left off.");
                }
              }())
            ],
          )),
      bottomNavigationBar: MyMenu(
        meIcon: CupertinoIcons.person,
        searchIcon: CupertinoIcons.search,
        homeIcon: CupertinoIcons.home,
        wishlistIcon: CupertinoIcons.heart_solid,
      ),
    );
  }
}
