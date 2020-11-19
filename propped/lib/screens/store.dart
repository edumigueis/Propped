import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:propped/models/Image.dart';
import 'package:propped/models/Product.dart';
import 'package:propped/models/Store.dart';
import 'package:propped/screens/home.dart';
import 'package:propped/screens/product.dart';
import 'package:propped/utils/Constants.dart';
import 'package:propped/widgets/customAppBar.dart';
import 'package:propped/widgets/menu.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:propped/widgets/productGridItem.dart';

class MyStore extends StatefulWidget {
  MyStore({Key key, @required int id})
      : this.id = id,
        super(key: key);

  final int id;

  @override
  _MyStoreState createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore> {
  Store store = new Store(name: "", country: "", city: "");

  @override
  void initState() {
    super.initState();
    fetchStore(widget.id);
  }

  void _showModal() {
    showCupertinoModalBottomSheet(
        expand: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context, ScrollController sc) => Material(
                child: SafeArea(
              top: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("About",
                        style: TextStyle(
                            fontSize: 17,
                            height: 2,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(30, 30, 30, 1))),
                    ListTile(
                      title: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras fermentum eros et nisi iaculis ornare. Ut condimentum sollicitudin felis a mattis. Praesent dignissim tellus ligula, non egestas odio fermentum non. Phasellus volutpat purus at leo tristique, nec lobortis erat viverra."),
                      contentPadding: EdgeInsets.symmetric(vertical: 7),
                    ),
                    Text("Phone",
                        style: TextStyle(
                            fontSize: 17,
                            height: 2,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(30, 30, 30, 1))),
                    ListTile(
                      title: Text(this.store.phone),
                      contentPadding: EdgeInsets.symmetric(vertical: 7),
                    ),
                    Text("Website",
                        style: TextStyle(
                            fontSize: 17,
                            height: 2,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(30, 30, 30, 1))),
                    ListTile(
                      title: Text(this.store.website),
                      contentPadding: EdgeInsets.symmetric(vertical: 7),
                    ),
                    Text("Location",
                        style: TextStyle(
                            fontSize: 17,
                            height: 2,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(30, 30, 30, 1))),
                    ListTile(
                      title: Text(() {
                        return this.store.city +
                            ", " +
                            this.store.state +
                            ", " +
                            this.store.country;
                      }()),
                      contentPadding: EdgeInsets.symmetric(vertical: 7),
                    ),
                  ],
                ),
              ),
            )));
  }

  Future<Store> fetchStore(int code) async {
    debugPrint('http://' + Constants.serverIP + '/stores/' + code.toString());
    final response = await http
        .get('http://' + Constants.serverIP + '/stores/' + code.toString());

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values = new List<dynamic>();
      values = json.decode(response.body);
      if (values.length > 0) {
        if (values[0] != null) {
          Map<String, dynamic> map = values[0];
          this.store = Store.fromJson(map);
        }
      }
      await fetchProductsByDesigners();
      if (this.mounted) setState(() {});
      return store;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load user');
    }
  }

  Future<List<Product>> fetchProductsByDesigners() async {
    debugPrint('http://' +
        Constants.serverIP +
        '/products/store/' +
        this.store.id.toString());
    final response = await http.get('http://' +
        Constants.serverIP +
        '/products/store/' +
        this.store.id.toString());

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values = new List<dynamic>();
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            productsDesigner.add(Product.fromJson(map));
          }
        }
      }
      if (this.mounted) setState(() {});
      await fetchImages();
      return productsDesigner;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load products from this store');
    }
  }

  List<Product> productsDesigner = new List<Product>();
  List<ImageObj> images = new List<ImageObj>();

  Future<List<ImageObj>> fetchImages() async {
    for (int f = 0; f < this.productsDesigner.length; f++) {
      debugPrint('http://' +
          Constants.serverIP +
          '/products/image/' +
          this.productsDesigner[f].id.toString());
      final response = await http.get('http://' +
          Constants.serverIP +
          '/products/image/' +
          this.productsDesigner[f].id.toString());
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        List<dynamic> values = new List<dynamic>();
        values = json.decode(response.body);
        if (values.length > 0) {
          if (values[0] != null) {
            Map<String, dynamic> map = values[0];
            this.images.add(ImageObj.fromJson(map));
          }
        }
      } else {
        // If that call was not successful, throw an error.
        this.images.add(new ImageObj(url: "", idImage: -1, idProduct: -1));
      }
    }
    await fetchImagesProp();
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
      appBar: CustomAppBar(showArrow: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: ListView(
            physics: new BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: 90),
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 125,
                  width: 125,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://images.pexels.com/photos/2101839/pexels-photo-2101839.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"))),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20, bottom: 15),
                child: Text(this.store.name,
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(30, 30, 30, 1))),
              ),
              Center(
                child: Text(
                    this.store.city.toUpperCase() +
                        ", " +
                        this.store.country.toUpperCase(),
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w900,
                        color: Color.fromRGBO(30, 30, 30, 1))),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                        onPressed: () {
                          _showModal();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        color: Color.fromARGB(255, 30, 30, 30),
                        child: Text('SEE MORE',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(240, 240, 240, 1))))),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyHome()),
                          );
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: BorderSide(
                                color: Color.fromRGBO(30, 30, 30, 1),
                                width: 2.5)),
                        color: Colors.white,
                        child: Text('RATINGS',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(30, 30, 30, 1))))),
              ),
              GridView.count(
                padding: const EdgeInsets.only(top: 20),
                physics: new BouncingScrollPhysics(),
                shrinkWrap: true,
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeight),
                // Generate 100 widgets that display their index in the List.
                children: List.generate(productsDesigner.length, (index) {
                  String img;
                  if (images == null || images.length == 0)
                    img = "";
                  else if (images[index] == null)
                    img = "";
                  else
                    img = images[index].url;
                  return ProductGridItem(
                      redirectCode: productsDesigner[index].code,
                      image: img,
                      text1: this.store.name,
                      text2: productsDesigner[index].name,
                      text3: productsDesigner[index].price.toString(),
                      isFavorite: false);
                }),
              ),
            ],
          ),
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
