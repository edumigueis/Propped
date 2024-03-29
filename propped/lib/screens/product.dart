import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:propped/models/BagItem.dart';
import 'package:propped/models/Image.dart';
import 'package:propped/screens/cart.dart';
import 'package:propped/models/Product.dart';
import 'package:propped/models/Attribute.dart';
import 'package:propped/screens/store.dart';
import 'package:propped/utils/Constants.dart';
import 'package:propped/models/Store.dart';
import 'package:propped/widgets/customAppBar.dart';
import 'package:propped/widgets/errorMsgWidget.dart';
import 'package:propped/widgets/menu.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MyProduct extends StatefulWidget {
  String code;

  MyProduct({Key key, @required String code})
      : this.code = code,
        super(key: key);

  @override
  _MyProductState createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  int _activeMeterIndex;
  String sizeOption = 'Select your size';
  var _availableSizeColor = Colors.black38;
  List<Attribute> productDetails;
  bool productExists = true;

  Product product = new Product(
      id: 0,
      code: "a",
      name: "Not Available",
      description: "alo",
      weight: 300,
      price: 19,
      stock: 10);

  Store store = new Store(name: "Couldn't load store");

  List<ImageObj> images = new List<ImageObj>();
  List<String> sizes = new List<String>();

  Future<Product> fetchProducts() async {
    final response = await http
        .get('http://' + Constants.serverIP + '/products/' + widget.code);

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
      getAvailableSizes();
      await fetchStore(this.product.store);
      //await fetchImages(this.product.code);
      if (this.mounted) setState(() {});
      return product;
    } else {
      this.productExists = false;
    }
  }

  Future<Store> fetchStore(int id) async {
    final response = await http
        .get('http://' + Constants.serverIP + '/stores/' + id.toString());

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
      await fetchImages(this.product.id.toString());
      return store;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load product');
    }
  }

  Future<List<ImageObj>> fetchImages(String code) async {
    final response = await http
        .get('http://' + Constants.serverIP + '/products/images/' + code);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values = new List<dynamic>();
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            this.images.add(ImageObj.fromJson(map));
          }
        }
      }
      await fetchImagesProp();
      return images;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load images');
    }
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
        throw Exception('Failed to load image url');
      }
    }
    return images;
  }

  void getAvailableSizes(){
    this.sizes = ["XXS", "XS", "S", "M", "L", "XL", "XXL", "XXXL", "XXXL"];
    if(this.product.sizes != null)
    {
      var temp = this.product.sizes.split("#");
      temp.removeLast();
      temp.removeAt(0);
      setState(() {
        this.sizes = temp;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  _closeModal(int index) {
    Navigator.of(context).pop();

    setState(() {
      sizeOption = sizes[index];
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
                children: List.generate(this.sizes.length, (index) {
                  return ListTile(
                    title: Text(this.sizes[index]),
                    contentPadding: EdgeInsets.symmetric(horizontal: 30),
                    onTap: () => _closeModal(index),
                  );
                }),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RawMaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () => {
          if (this.productExists)
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyShoppingBag(
                          bagitem: new BagItem(
                              product: this.product,
                              quantity: 1,
                              size: this.sizeOption),
                        )),
              )
            }
          else
            {Navigator.pop(context)}
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
                () {
                  if (this.productExists) {
                    return "ADD TO BAG";
                  } else
                    return "GO BACK";
                }(),
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
      body: () {
        if (this.productExists) {
          return ListView(
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
                items: images.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage("" + i.url),
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
                      this.store.name,
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
                  margin:
                      EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 30),
                  child: GestureDetector(
                    //APENAS MOSTRAR TAMANHOS DISPONÍVEIS A PARTIR DO TRATAMENTO DA STRING DO CAMPO size_product
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
                                          return "Designer - " +
                                              this.store.name;
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
                                              itemBuilder: (BuildContext ctx,
                                                  int index) {
                                                return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text("Sleeves Length",
                                                          style: new TextStyle(
                                                              fontSize: 17.0,
                                                              fontFamily:
                                                                  'Ubuntu',
                                                              height: 1.4,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal)),
                                                      Text("35cm",
                                                          style: new TextStyle(
                                                              fontSize: 17.0,
                                                              fontFamily:
                                                                  'Ubuntu',
                                                              height: 1.4,
                                                              fontWeight:
                                                                  FontWeight
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
                                              itemBuilder: (BuildContext ctx,
                                                  int index) {
                                                return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text("Main material",
                                                          style: new TextStyle(
                                                              fontSize: 17.0,
                                                              fontFamily:
                                                                  'Ubuntu',
                                                              height: 1.4,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal)),
                                                      Text("Cotton",
                                                          style: new TextStyle(
                                                              fontSize: 17.0,
                                                              fontFamily:
                                                                  'Ubuntu',
                                                              height: 1.4,
                                                              fontWeight:
                                                                  FontWeight
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
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                      this.store.description,
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
                                                  onPressed: () => {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MyStore(
                                                                  id: store
                                                                      .id)),
                                                    )
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    // Replace with a Row for horizontal icon + text
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                top: 15,
                                                                bottom: 15),
                                                        child: Text(
                                                          "See more from " +
                                                              store.name,
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      30,
                                                                      30,
                                                                      30,
                                                                      1),
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
          );
        } else {
          return ErrorMsgWidget(
              title: "Product not Available",
              message:
                  "The product you are trying to find doesn't exist or has been removed. Check your internet connection as well.");
        }
      }(),
      bottomNavigationBar: MyMenu(
        meIcon: CupertinoIcons.person,
        searchIcon: CupertinoIcons.search,
        homeIcon: CupertinoIcons.home,
        wishlistIcon: Icons.star_border,
      ),
    );
  }
}
