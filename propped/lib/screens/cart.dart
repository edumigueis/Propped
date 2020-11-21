import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:propped/models/BagItem.dart';
import 'package:propped/models/Product.dart';
import 'package:propped/models/Store.dart';
import 'package:propped/widgets/customAppBar.dart';
import 'package:propped/utils/Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:propped/widgets/errorMsgWidget.dart';
import 'package:propped/widgets/shoppingBagItem.dart';

class MyShoppingBag extends StatefulWidget {
  final BagItem bagitem;

  MyShoppingBag({Key key, BagItem bagitem})
      : this.bagitem = bagitem,
        super(key: key);

  @override
  _MyShoppingBagState createState() => _MyShoppingBagState();
}

class _MyShoppingBagState extends State<MyShoppingBag> {
  List<BagItem> bagItems;
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
            bagItems.add(new BagItem(product: Product.fromJson(map)));
          }
        }
      }
      if (this.mounted) setState(() {});
      return bagItems;
    } else {
      // If that call was not successful, throw an error.
      if (this.mounted) setState(() {});
      this.cartIsEmpty = true;
    }
  }

  @override
  void initState() {
    super.initState();
    //if (this.widget.bagitem != null) addItem(this.widget.bagitem);
    fetchProductsByCart();
    countries.shuffle();
  }

  List<String> countries = [
    "https://upload.wikimedia.org/wikipedia/en/thumb/0/03/Flag_of_Italy.svg/1200px-Flag_of_Italy.svg.png",
    "https://miro.medium.com/max/2470/0*o0-6o1W1DKmI5LbX.png",
    "https://upload.wikimedia.org/wikipedia/en/thumb/0/05/Flag_of_Brazil.svg/1200px-Flag_of_Brazil.svg.png",
    "https://static3.depositphotos.com/1000209/137/v/600/depositphotos_1377995-stock-illustration-france-flag.jpg",
    "https://upload.wikimedia.org/wikipedia/en/thumb/0/05/Flag_of_Brazil.svg/1200px-Flag_of_Brazil.svg.png",
  ];
  int randomNumber;
  int count = 0;

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
            if (!this.cartIsEmpty) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15),
                physics: new BouncingScrollPhysics(),
                itemCount: 5,
                itemBuilder: (BuildContext ctx, int i) {
                  if (i != 4) {
                    return ShoppingBagItem(
                      country: countries[i],
                      product: new Product(name: "Vulcanized Sneakers"),
                      store: new Store(name: "Off White"),
                      image:
                          "https://is4.revolveassets.com/images/p4/n/z/OFFF-MZ32_V1.jpg",
                      price: 110.0,
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
                                  text: 'USD \$80.0',
                                  style: TextStyle(
                                      fontSize: 16,
                                      height: 1.5,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(30, 30, 30, 1))),
                            ],
                          ),
                        ),
                        Text('USD \$80.0',
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
                                  text: 'USD \$0.0',
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
