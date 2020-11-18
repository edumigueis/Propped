import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:propped/models/BagItem.dart';
import 'package:propped/models/Product.dart';
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
  int idCart = 6;

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
      if (this.mounted) setState((){});
      return new BagItem();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load item');
    }
  }

  Future<List<BagItem>> fetchProductsByCart() async {
    final response =
    await http.get('http://' + Constants.serverIP + '/carts/products/'+ this.idCart.toString());

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
      throw Exception('Failed to load products from this store');
    }
  }

  @override
  void initState() {
    super.initState();
    //if (this.widget.bagitem != null) addItem(this.widget.bagitem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(showArrow: true, title: "Shopping Bag",),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              physics: new BouncingScrollPhysics(),
              itemCount: 6,
              itemBuilder: (BuildContext ctx, int i) {
                  if(i != 5){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 100,
                            margin: EdgeInsets.only(right: 10),
                            decoration: new BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://is4.revolveassets.com/images/p4/n/z/OFFF-MZ32_V1.jpg"),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                            width: (MediaQuery.of(context).size.width - 180),
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Off-White", style: TextStyle(
                                    fontSize: 19.0,
                                    fontFamily: 'Ubuntu',
                                    height: 1.5,
                                    fontWeight: FontWeight.w600)),
                                Text("Vulcanized Sneakers", style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Ubuntu',
                                    height: 1.5,
                                    fontWeight: FontWeight.normal)),
                                Container(
                                  width: 20,
                                  height: 20,
                                  margin: EdgeInsets.only(top: 15),
                                  decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(40)),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://upload.wikimedia.org/wikipedia/en/thumb/0/03/Flag_of_Italy.svg/1200px-Flag_of_Italy.svg.png"),
                                          fit: BoxFit.cover)),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            width: 60,
                            height: 40,
                            child: TextField(
                              expands: true,
                              minLines: null,
                              maxLines: null,
                              onChanged: (value) => {},
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black26,
                                          width: 1.0),
                                      borderRadius: BorderRadius.all(Radius.circular(3.5))),
                                  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                          Colors.black26,
                                          width: 1.0),
                                      borderRadius: BorderRadius.all(Radius.circular(3.5))),
                                  hintText: 'Qty 1'),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                    return Container(
                      color: CupertinoColors.systemGrey5,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      height: 100,
                      width: double.infinity,
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 70,
                            width: 70,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Icon(CupertinoIcons.car, size: 50, color: Color.fromRGBO(30, 30, 30, 1),),
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
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
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
