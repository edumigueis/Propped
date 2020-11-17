import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:propped/models/BagItem.dart';
import 'package:propped/widgets/customAppBar.dart';
import 'package:propped/utils/Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

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
  int idCart = 1;

  Future<BagItem> addItem(BagItem itemToAdd) async {
    final http.Response response = await http.post(
      'http://' + Constants.serverIP + '/cart',
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
      return new BagItem();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load item');
    }
  }

  @override
  void initState() {
    super.initState();
    if (this.widget.bagitem != null) addItem(this.widget.bagitem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showArrow: true),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              physics: new BouncingScrollPhysics(),
              itemCount: 8,
              itemBuilder: (BuildContext ctx, int i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 100,
                        margin: EdgeInsets.only(right: 10),
                        decoration: new BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://cdn-images.farfetch-contents.com/15/23/22/29/15232229_29297818_1000.jpg"),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width - 160),
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Off-White"),
                            Text("Vulcanized Sneakers"),
                            Container(
                              width: 60,
                              height: 60,
                              child: TextField(
                                onChanged: (value) => {},
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(30, 30, 30, 1),
                                            width: 4.0),
                                        borderRadius: BorderRadius.zero),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(30, 30, 30, 1),
                                            width: 3.0),
                                        borderRadius: BorderRadius.zero),
                                    hintText: 'Min'),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://upload.wikimedia.org/wikipedia/en/thumb/0/03/Flag_of_Italy.svg/1200px-Flag_of_Italy.svg.png"),
                                fit: BoxFit.cover)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
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
