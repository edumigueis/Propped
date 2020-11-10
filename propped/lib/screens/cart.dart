import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/widgets/customAppBar.dart';

class MyShoppingBag extends StatefulWidget {
  @override
  _MyShoppingBagState createState() => _MyShoppingBagState();
}

class _MyShoppingBagState extends State<MyShoppingBag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showArrow: true),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: 100,
              itemBuilder: (BuildContext ctx, int i) {
                return Text("aloalo");
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
