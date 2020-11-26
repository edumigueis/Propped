import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/models/BagItem.dart';
import 'package:propped/models/Image.dart';
import 'package:propped/models/Product.dart';
import 'package:propped/models/Store.dart';
import 'package:propped/widgets/customAppBar.dart';
import 'package:propped/utils/Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:propped/widgets/errorMsgWidget.dart';
import 'package:propped/widgets/shoppingBagItem.dart';
import 'package:flutter_session/flutter_session.dart';

class MyShoppingBag extends StatefulWidget {
  final BagItem bagitem;

  MyShoppingBag({Key key, BagItem bagitem})
      : this.bagitem = bagitem,
        super(key: key);

  @override
  _MyShoppingBagState createState() => _MyShoppingBagState();
}

class _MyShoppingBagState extends State<MyShoppingBag> {
  List<BagItem> bagItems = new List<BagItem>();
  int idCart = 6;
  bool cartIsEmpty = false;

  Future<BagItem> addItem(BagItem itemToAdd) async {
    final http.Response response = await http.post(
      'http://' + Constants.serverIP + '/carts/product',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id_product_productsshoppingcart': widget.bagitem.product.id.toString(),
        'id_shoppingcart_productsshoppingcart': this.idCart.toString(),
        'amount_productsshoppingcart': widget.bagitem.quantity.toString(),
      }),
    );
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      bagItems.add(widget.bagitem);
      if (this.mounted) setState(() {});
      return new BagItem();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load item');
    }
  }

  Future<List<BagItem>> fetchProductsByCart() async {
    final response = await http.get('http://' +
        Constants.serverIP +
        '/carts/products/' +
        this.idCart.toString());

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values = new List<dynamic>();
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            bagItems.add(new BagItem(
                product: Product.fromJson(map),
                quantity: map['amount_productsshoppingcart']));
          }
        }
      }
      shuffleAndAttributeCountries();
      if (this.mounted) setState(() {});
      await fetchStores();
      return bagItems;
    } else {
      // If that call was not successful, throw an error.
      if (this.mounted) setState(() {});
      this.cartIsEmpty = true;
    }
  }

  Future<List<BagItem>> fetchStores() async {
    for (int f = 0; f < this.bagItems.length; f++) {
      final response = await http.get('http://' +
          Constants.serverIP +
          '/stores/' +
          this.bagItems[f].product.store.toString());

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        List<dynamic> values = new List<dynamic>();
        values = json.decode(response.body);
        if (values.length > 0) {
          if (values[0] != null) {
            Map<String, dynamic> map = values[0];
            bagItems[f].store = Store.fromJson(map);
          }
        }
      } else {
        // If that call was not successful, throw an error.
        if (this.mounted)
          setState(() {
            this.cartIsEmpty = true;
          });
      }
    }
    fetchImages();
    if (this.mounted) setState(() {});
    return bagItems;
  }

  List<ImageObj> images = new List<ImageObj>();

  Future<List<BagItem>> fetchImages() async {
    for (int f = 0; f < this.bagItems.length; f++) {
      final response = await http.get('http://' +
          Constants.serverIP +
          '/products/image/' +
          bagItems[f].product.id.toString());

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
        this.images.add(new ImageObj());
      }
    }
    await fetchImagesProp();
    return bagItems;
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
        this.images[f].url =
            "https://cdn.dribbble.com/users/257123/screenshots/13967127/media/20ea6c404c5787a1dca1180abd01905b.png";
      }
    }
    if (this.mounted) setState(() {});
    return images;
  }

  Future<int> fetchCountOfProducts() async{
    final response = await http.get('http://' +
        Constants.serverIP +
        '/products/count/' +
        await FlutterSession().get("id").toString());

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values = new List<dynamic>();
      values = json.decode(response.body);

      if (values.length > 0) {
        if (values[0] != null) {
          Map<String, dynamic> map = values[0];
          setState(() {
            Constants.spBagItems = map['count'];
          });
        }
      }
    } else {
      setState(() {
        Constants.spBagItems = 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //if (this.widget.bagitem != null) addItem(this.widget.bagitem);
    fetchProductsByCart();
    fetchCountOfProducts();
  }

  List<String> countries = [
    "https://upload.wikimedia.org/wikipedia/en/thumb/0/03/Flag_of_Italy.svg/1200px-Flag_of_Italy.svg.png",
    "https://miro.medium.com/max/2470/0*o0-6o1W1DKmI5LbX.png",
    "https://upload.wikimedia.org/wikipedia/en/thumb/0/05/Flag_of_Brazil.svg/1200px-Flag_of_Brazil.svg.png",
    "https://static3.depositphotos.com/1000209/137/v/600/depositphotos_1377995-stock-illustration-france-flag.jpg",
    "https://upload.wikimedia.org/wikipedia/en/thumb/0/05/Flag_of_Brazil.svg/1200px-Flag_of_Brazil.svg.png",
  ];

  shuffleAndAttributeCountries() {
    if (bagItems.length > 0 && bagItems[0] != null) {
      var rng = new Random();
      for (int i = 0; i < bagItems.length; i++) {
        bagItems[i].country = countries[rng.nextInt(countries.length - 1)];
      }
    }
  }

  int count = 0;
  double shipping = 20;

  double calcFinalAmount() {
    if (this.bagItems.length > 0 && this.bagItems != null) {
      double finalAmount = 0.0;
      for (int f = 0; f < bagItems.length; f++) {
        finalAmount += this.bagItems[f].product.price;
      }
      return finalAmount;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        showArrow: true,
        title: "Shopping Bag",
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: () {
            if (!this.cartIsEmpty && bagItems != null) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15),
                physics: new BouncingScrollPhysics(),
                itemCount: bagItems.length + 1,
                itemBuilder: (BuildContext ctx, int i) {
                  if (i != bagItems.length) {
                    return ShoppingBagItem(
                      country: () {
                        if (bagItems[i].country != "" &&
                            bagItems[i].country != null)
                          return bagItems[i].country;
                        else
                          return "https://images.fineartamerica.com/images/artworkimages/mediumlarge/3/off-white-linen-white-ultra-pale-gray-solid-color-parable-to-behr-dutch-white-mq3-31-melissa-fague.jpg";
                      }(),
                      product: bagItems[i].product,
                      store: bagItems[i].store,
                      image: () {
                        if (images != null) {
                          if (images.length > 0) {
                            if (images[i] != null || images[i].url == null) {
                              return images[i].url;
                            }
                          }
                        }
                        return "https://images.fineartamerica.com/images/artworkimages/mediumlarge/3/off-white-linen-white-ultra-pale-gray-solid-color-parable-to-behr-dutch-white-mq3-31-melissa-fague.jpg";
                      }(),
                      price: bagItems[i].product.price,
                      quantity: bagItems[i].quantity,
                      onDispose: () {
                        setState(() {
                          debugPrint(bagItems[0].toString());
                          bagItems.removeAt(i);
                        });
                      },
                    );
                  }
                  return Container(
                    color: CupertinoColors.systemGrey5,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: double.infinity,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 70,
                          width: 70,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(
                            CupertinoIcons.car,
                            size: 50,
                            color: Color.fromRGBO(30, 30, 30, 1),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Free Return Policy",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(40, 40, 40, 1)),
                                  textAlign: TextAlign.left),
                              Container(
                                margin: const EdgeInsets.only(top: 8.0),
                                width: MediaQuery.of(context).size.width / 1.8,
                                child: Text(
                                  "All items can be returned for free",
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromRGBO(40, 40, 40, 1)),
                                  textAlign: TextAlign.left,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              return ErrorMsgWidget(
                  title: "Your shopping bag is empty",
                  message:
                      "Add products to bag to see them here and buy them at any time.");
            }
          }()),
          Container(
            height: 170,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20.0))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio:
                          (MediaQuery.of(context).size.width / 2 / 30),
                      children: <Widget>[
                        Text("   "),
                        Text("Total   ",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.normal,
                                color: Color.fromRGBO(30, 30, 30, 1))),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Subtotal    ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      height: 1.5,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromRGBO(30, 30, 30, 1))),
                              TextSpan(
                                  text: 'USD \$' +
                                      () {
                                        if (calcFinalAmount() == null)
                                          return "0.00";
                                        else
                                          return calcFinalAmount().toString();
                                      }(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      height: 1.5,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(30, 30, 30, 1))),
                            ],
                          ),
                        ),
                        Text(
                            'USD \$' +
                                () {
                                  if (shipping == null &&
                                      calcFinalAmount() == null) return "0.00";
                                  if (shipping == null &&
                                      calcFinalAmount() != null)
                                    return calcFinalAmount();
                                  if (shipping != null &&
                                      calcFinalAmount() == null)
                                    return shipping;

                                  return (shipping + calcFinalAmount());
                                }()
                                    .toString(),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(30, 30, 30, 1))),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Shipping    ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      height: 1.5,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromRGBO(30, 30, 30, 1))),
                              TextSpan(
                                  text: 'USD \$' + this.shipping.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      height: 1.5,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(30, 30, 30, 1))),
                            ],
                          ),
                        ),
                      ].map((Widget w) {
                        return w;
                      }).toList()),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            color: Color.fromARGB(255, 30, 30, 30),
                            child: Text('CHECKOUT',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(240, 240, 240, 1))))),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
