import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:propped/screens/home.dart';
import 'package:propped/models/Product.dart';
import 'package:propped/models/Attribute.dart';
import 'package:propped/utils/Constants.dart';
import 'package:propped/models/Store.dart';
import 'package:propped/widgets/customAppBar.dart';
import 'package:propped/widgets/menu.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MyProduct extends StatefulWidget {
  @override
  _MyProductState createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  int _activeMeterIndex;
  String sizeOption = 'Select your size';
  var _availableSizeColor = Colors.black38;
  String codeProduct =
      "0V89SN8U4CAXJKR6CKOSVENHT79GQ1"; //will be given by the previous widget
  List<Attribute> productDetails;

  Product product = new Product(
      id: 0,
      code: "a",
      name: "Not Available",
      description: "alo",
      weight: 300,
      price: 19,
      stock: 10);

  Store store = new Store(name: "Couldn't load store");

  Future<Product> fetchProducts() async {
    final response = await http
        .get('http://' + Constants.serverIP + '/products/' + this.codeProduct);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values = new List<dynamic>();
      values = json.decode(response.body);
      if (values.length > 0) {
        if (values[0] != null) {
          Map<String, dynamic> map = values[0];
          this.product = Product.fromJson(map);
        }
      }
      await fetchStore(this.product.store);
      if (this.mounted) setState(() {});
      return product;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load product');
    }
  }

  Future<Store> fetchStore(int id) async {
    final response =
        await http.get('http://' + Constants.serverIP + '/stores/' + '1');

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
      return store;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load product');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
    debugPrint(this.product.name);
  }

  _closeModal(int index) {
    Navigator.of(context).pop();
    debugPrint(index.toString());

    setState(() {
      switch (index) {
        case 0:
          {
            sizeOption = "XXS";
          }
          break;
        case 1:
          {
            sizeOption = "XS";
          }
          break;
        case 2:
          {
            sizeOption = "S";
          }
          break;
        case 3:
          {
            sizeOption = "M";
          }
          break;
        case 4:
          {
            sizeOption = "L";
          }
          break;
        case 5:
          {
            sizeOption = "XL";
          }
          break;
        case 6:
          {
            sizeOption = "XXL";
          }
          break;
      }
      _availableSizeColor = Color.fromRGBO(30, 30, 30, 1);
    });
  }

  void _showModal() {
    showCupertinoModalBottomSheet(
        expand: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context, ScrollController sc) => Material(
                child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text('XXS'),
                    contentPadding: EdgeInsets.symmetric(horizontal: 30),
                    onTap: () => _closeModal(0),
                  ),
                  ListTile(
                    title: Text('XS'),
                    contentPadding: EdgeInsets.symmetric(horizontal: 30),
                    onTap: () => _closeModal(1),
                  ),
                  ListTile(
                    title: Text('S'),
                    contentPadding: EdgeInsets.symmetric(horizontal: 30),
                    onTap: () => _closeModal(2),
                  ),
                  ListTile(
                    title: Text('M'),
                    contentPadding: EdgeInsets.symmetric(horizontal: 30),
                    onTap: () => _closeModal(3),
                  ),
                  ListTile(
                    title: Text('L'),
                    contentPadding: EdgeInsets.symmetric(horizontal: 30),
                    onTap: () => _closeModal(4),
                  ),
                  ListTile(
                    title: Text('XL'),
                    contentPadding: EdgeInsets.symmetric(horizontal: 30),
                    onTap: () => _closeModal(5),
                  ),
                  ListTile(
                    title: Text('XXL'),
                    contentPadding: EdgeInsets.symmetric(horizontal: 30),
                    onTap: () => _closeModal(6),
                  )
                ],
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RawMaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHome()),
          )
        },
        child: Container(
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Color.fromARGB(255, 30, 30, 30)),
            margin: EdgeInsets.only(left: 15, right: 15),
            height: 50,
            width: MediaQuery.of(context).size.width - 60,
            child: Center(
              child: Text(
                "ADD TO BAG",
                style: new TextStyle(
                    fontSize: 15,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(240, 240, 240, 1)),
                textAlign: TextAlign.center,
              ),
            )),
      ),
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(showArrow: true),
      backgroundColor: Colors.white,
      body: ListView(
        physics: new BouncingScrollPhysics(),
        padding: const EdgeInsets.all(0),
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
                height: 500,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(milliseconds: 14000),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal),
            items: [
              "https://cdn-images.farfetch-contents.com/15/57/78/62/15577862_28040975_1000.jpg",
              "https://cdn-images.farfetch-contents.com/15/57/78/62/15577862_28040977_1000.jpg",
              "https://cdn-images.farfetch-contents.com/15/57/78/62/15577862_28037975_1000.jpg",
              "https://cdn-images.farfetch-contents.com/15/57/78/62/15577862_28037978_1000.jpg"
            ].map((i) {
              // guardar objetos em cada uma das posições do vetor e acessar os campos no builder
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("$i"),
                          fit: BoxFit.cover,
                          repeat: ImageRepeat.noRepeat),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              children: <Widget>[
                Text(
                  "Balmain",
                  style: TextStyle(
                      fontSize: 21.0,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  this.product.name,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Ubuntu',
                      height: 1.6,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "R\$" + this.product.price.toString(),
                  style: TextStyle(
                      fontSize: 19.0,
                      fontFamily: 'Ubuntu',
                      height: 2.2,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "12 x R\$" +
                      (this.product.price / 12).toString().substring(0, 4),
                  style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Ubuntu',
                      height: 1.6,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          Container(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Colors.black26),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              margin: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 30),
              child: GestureDetector(
                onTap: _showModal,
                child: Container(
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("$sizeOption",
                                style: TextStyle(
                                    fontSize: 19.0,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.w500,
                                    color: _availableSizeColor)),
                            Icon(
                              CupertinoIcons.down_arrow,
                              color: Colors.black87,
                            )
                          ],
                        ))),
              )),
          ListView.builder(
              padding: EdgeInsets.only(top: 0, bottom: 100),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: 4,
              itemBuilder: (BuildContext context, index) {
                return Container(
                    decoration: new BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.black26),
                      ),
                    ),
                    margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Theme(
                          data: ThemeData(
                              dividerColor: Colors.transparent,
                              accentColor: Color.fromRGBO(30, 30, 30, 1)),
                          child: ExpansionTile(
                            title: Text(
                              (() {
                                switch (index) {
                                  case 0:
                                    return "Description";
                                    break;
                                  case 1:
                                    return "Size & Fit";
                                    break;
                                  case 2:
                                    return "Composition & Care";
                                    break;
                                  case 3:
                                    if (this.store.name.length < 20)
                                      return "Designer - " + this.store.name;
                                    else
                                      return "Designer - " +
                                          this.store.name.substring(0, 19) +
                                          "...";
                                    break;
                                }
                                return "Description";
                              })(),
                              style: new TextStyle(
                                  fontSize: 22.0,
                                  fontFamily: 'Ubuntu',
                                  height: 1.6,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(
                              Icons.keyboard_arrow_down,
                              color: Color.fromRGBO(30, 30, 30, 1),
                              size: 35,
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 17, vertical: 10),
                                child: Container(child: (() {
                                  switch (index) {
                                    case 0:
                                      return Text(
                                        this.product.description,
                                        style: new TextStyle(
                                            fontSize: 17.0,
                                            fontFamily: 'Ubuntu',
                                            height: 1.1,
                                            fontWeight: FontWeight.normal),
                                      );
                                      break;
                                    case 1:
                                      return ListView.builder(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          shrinkWrap: true,
                                          physics:
                                              new NeverScrollableScrollPhysics(),
                                          itemCount: 4,
                                          itemBuilder:
                                              (BuildContext ctx, int index) {
                                            return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text("Sleeves Length",
                                                      style: new TextStyle(
                                                          fontSize: 17.0,
                                                          fontFamily: 'Ubuntu',
                                                          height: 1.4,
                                                          fontWeight: FontWeight
                                                              .normal)),
                                                  Text("35cm",
                                                      style: new TextStyle(
                                                          fontSize: 17.0,
                                                          fontFamily: 'Ubuntu',
                                                          height: 1.4,
                                                          fontWeight: FontWeight
                                                              .normal))
                                                ]);
                                          });
                                      break;
                                    case 2:
                                      return ListView.builder(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          shrinkWrap: true,
                                          physics:
                                              new NeverScrollableScrollPhysics(),
                                          itemCount: 4,
                                          itemBuilder:
                                              (BuildContext ctx, int index) {
                                            return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text("Main material",
                                                      style: new TextStyle(
                                                          fontSize: 17.0,
                                                          fontFamily: 'Ubuntu',
                                                          height: 1.4,
                                                          fontWeight: FontWeight
                                                              .normal)),
                                                  Text("Cotton",
                                                      style: new TextStyle(
                                                          fontSize: 17.0,
                                                          fontFamily: 'Ubuntu',
                                                          height: 1.4,
                                                          fontWeight: FontWeight
                                                              .normal))
                                                ]);
                                          });
                                      break;
                                    case 3:
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10, top: 7),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed iaculis, risus in porta accumsan, augue sem vulputate diam, pretium pretium massa ligula id ante. Mauris laoreet mattis mauris, vitae feugiat justo ultrices et. Curabitur lacinia leo vitae leo laoreet, vitae consequat sapien tincidunt.",
                                                //here store description will be added
                                                style: new TextStyle(
                                                    fontSize: 17.0,
                                                    fontFamily: 'Ubuntu',
                                                    height: 1.1,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 18),
                                            child: OutlinedButton(
                                              onPressed: () => {},
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                // Replace with a Row for horizontal icon + text
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8,
                                                            top: 15,
                                                            bottom: 15),
                                                    child: Text(
                                                      "See more from " +
                                                          store.name,
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              30, 30, 30, 1),
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Color.fromRGBO(
                                                        30, 30, 30, 1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                      break;
                                  }
                                  return Text(
                                    this.product.description,
                                    style: new TextStyle(
                                        fontSize: 17.0,
                                        fontFamily: 'Ubuntu',
                                        height: 1.1,
                                        fontWeight: FontWeight.normal),
                                  );
                                })()),
                              )
                            ],
                          ),
                        )));
              })
        ],
      ),
      bottomNavigationBar: MyMenu(
        meIcon: CupertinoIcons.person,
        searchIcon: CupertinoIcons.search,
        homeIcon: CupertinoIcons.home,
        wishlistIcon: Icons.star_border,
      ),
    );
  }
}
