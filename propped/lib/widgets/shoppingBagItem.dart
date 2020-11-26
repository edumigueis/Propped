import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:propped/models/Product.dart';
import 'package:propped/models/Store.dart';
import 'package:propped/screens/product.dart';

typedef DisposeCallback = void Function();

class ShoppingBagItem extends StatelessWidget {
  ShoppingBagItem(
      {Key key,
      @required this.country,
      @required this.product,
      @required this.store,
      @required this.image,
      @required this.price,
      @required this.quantity,
      @required this.onDispose})
      : super(key: key);

  String country;
  Product product;
  Store store;
  String image;
  int price;
  int quantity;
  DisposeCallback onDispose;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyProduct(
                    code: this.product.code,
                  )),
        );
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: 100,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 18.0),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 100,
              margin: EdgeInsets.only(right: 10),
              decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(this.image), fit: BoxFit.cover)),
            ),
            Container(
              width: (MediaQuery.of(context).size.width - 180),
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(this.product.name,
                      style: TextStyle(
                          fontSize: 19.0,
                          fontFamily: 'Ubuntu',
                          height: 1.5,
                          fontWeight: FontWeight.w600)),
                  Text(() {
                    if (this.store != null && this.store.name != "")
                      return this.store.name;
                    else
                      return "Error";
                  }(),
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
                        child: Text("USD \$" + this.price.toString(),
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
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            image: DecorationImage(
                                image: NetworkImage(country),
                                fit: BoxFit.cover)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    width: 60,
                    height: 40,
                    margin: EdgeInsets.only(top: 15),
                    child: TextField(
                      expands: true,
                      minLines: null,
                      maxLines: null,
                      onChanged: (value) => {},
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black26, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3.5))),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black26, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3.5))),
                          hintText: 'Qty ' + this.quantity.toString()),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: GestureDetector(
                    onTap: () => {onDispose()},
                    child: Icon(
                      CupertinoIcons.clear,
                      size: 30,
                      color: Color.fromRGBO(30, 30, 30, 1),
                    ),
                  ),
                  top: 0,
                  right: 0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
