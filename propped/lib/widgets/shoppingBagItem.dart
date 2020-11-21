import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:propped/models/Product.dart';
import 'package:propped/models/Store.dart';
import 'package:propped/screens/product.dart';

class ShoppingBagItem extends StatefulWidget {
  ShoppingBagItem(
      {Key key,
        @required this.country,
        @required this.product,
        @required this.store,
        @required this.image,
      @required this.price})
      : super(key: key);

  String country;
  Product product;
  Store store;
  String image;
  double price;

  @override
  ShoppingBagItemState createState() => ShoppingBagItemState();
}

class ShoppingBagItemState extends State<ShoppingBagItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 100,
            margin: EdgeInsets.only(right: 10),
            decoration: new BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        this.widget.image),
                    fit: BoxFit.cover)),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 180),
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(this.widget.store.name,
                    style: TextStyle(
                        fontSize: 19.0,
                        fontFamily: 'Ubuntu',
                        height: 1.5,
                        fontWeight: FontWeight.w600)),
                Text(this.widget.store.name,
                    style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Ubuntu',
                        height: 1.5,
                        fontWeight: FontWeight.normal)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: Text("USD \$" + this.widget.price.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w600)),
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      margin: EdgeInsets.only(top: 15, left: 10),
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(40)),
                          image: DecorationImage(
                              image: NetworkImage(widget.country),
                              fit: BoxFit.cover)),
                    ),
                  ],
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
                          color: Colors.black26, width: 1.0),
                      borderRadius:
                      BorderRadius.all(Radius.circular(3.5))),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 5, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black26, width: 1.0),
                      borderRadius:
                      BorderRadius.all(Radius.circular(3.5))),
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
}
