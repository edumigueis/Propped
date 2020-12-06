import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:propped/screens/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:propped/utils/Constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key key, String title, @required bool showArrow, bool isCart})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        this.showArrow = showArrow,
        this.title = title,
        this.isCart = isCart,
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0
  final String title;
  final bool showArrow;
  final bool isCart;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {

  @override
  void initState(){
    super.initState();
    fetchCount();
  }

  Future<int> fetchCount() async {
    int idUser = await FlutterSession().get("id");
    final response = await http.get(
        'http://' + Constants.serverIP + '/carts/products/count/' + idUser.toString());

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values = new List<dynamic>();
      values = json.decode(response.body);

      if (values.length > 0) {
        if (values[0] != null) {
          Map<String, dynamic> map = values[0];
          setState(() {
            Constants.spBagItems = map['count'];
            debugPrint("items:" + Constants.spBagItems.toString());
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
  Widget build(BuildContext context) {
    return AppBar(
      title: () {
        if (widget.title != null) {
          if (widget.title.trim() != "") {
            return Text(
              widget.title,
              style: TextStyle(
                  color: Color.fromRGBO(30, 30, 30, 1),
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w500),
            );
          } else
            return Text("");
        }
      }(),
      automaticallyImplyLeading: widget.showArrow,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
        size: 30,
      ),
      backgroundColor: Colors.transparent,
      actions: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyShoppingBag()),
          ),
          child: Row(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Text(
                    Constants.spBagItems.toString(),
                    style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(30, 30, 30, 1)),
                  ),
                ),
              ),
              Container(
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                            image: NetworkImage(
                                "https://freeiconshop.com/wp-content/uploads/edd/shopping-bag-outline.png"),
                            fit: BoxFit.cover)),
                  ),
                  margin: const EdgeInsets.only(right: 10)),
            ],
          ),
        )
      ],
    );
  }
}
