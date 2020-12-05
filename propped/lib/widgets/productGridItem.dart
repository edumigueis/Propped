import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/models/Favorite.dart';
import 'package:propped/screens/product.dart';
import 'package:propped/utils/Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ProductGridItem extends StatefulWidget {
  ProductGridItem({Key key,
    @required this.text1,
    @required this.text2,
    @required this.text3,
    @required this.image,
    @required this.isFavorite,
    @required this.favorite,
    @required this.redirectCode})
      : super(key: key);

  String text1;
  String text2;
  String text3;
  String image;
  bool isFavorite;
  String redirectCode;
  Favorite favorite;

  @override
  ProductGridItemState createState() => ProductGridItemState();
}

class ProductGridItemState extends State<ProductGridItem> {
  Future<bool> checkFavorite() async {
    final response = await http.get('http://' +
        Constants.serverIP +
        '/favorites/product/' +
        this.widget.favorite.user.toString() + "/" +
        this.widget.favorite.product.toString());

    if (response.statusCode == 200) {
      setState(() {
        this.widget.isFavorite = true;
      });
    } else {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    if (this.widget.isFavorite == false)
      checkFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      GestureDetector(
        onTap: () =>
        {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MyProduct(
                      code: widget.redirectCode,
                    )),
          )
        },
        child: Container(
            margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
            height: MediaQuery
                .of(context)
                .size
                .height / 3,
            width: MediaQuery
                .of(context)
                .size
                .width / 2,
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(() {
                      if (this.widget.image != null) {
                        if (this.widget.image.contains("http") &&
                            this.widget.image.trim() != "")
                          return this.widget.image;
                      }
                      return "https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/109852763/original/e9f05328b042adf5ef076bf637296a484a609342/create-trendy-abstract-geometric-pattern-on-light-background.jpg";
                    }())),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () =>
                      {
                        if (this.widget.isFavorite == false)
                          {
                            Favorite.save(new Favorite(
                                user: this.widget.favorite.user,
                                product: this.widget.favorite.product))
                          }
                        else
                          {
                            if (this.widget.isFavorite == true)
                              Favorite.delete(this.widget.favorite)
                          },
                        setState(() {
                          this.widget.isFavorite
                              ? this.widget.isFavorite = false
                              : this.widget.isFavorite = true;
                        })
                      },
                      child: () {
                        if (this.widget.isFavorite)
                          return new Icon(Icons.star, size: 30);
                        else
                          return new Icon(Icons.star_border, size: 30);
                      }()),
                ),
              ],
            )),
      ),
      Text(this.widget.text1,
          style: TextStyle(
              fontSize: 15.0,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(120, 120, 120, 1)),
          textAlign: TextAlign.center),
      Text((){
        if(this.widget.text2.length > 15)
          return this.widget.text2.substring(0, 16) + "...";
        else
          return this.widget.text2;
    }(),
          style: TextStyle(
              fontSize: 19.0,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w700,
              color: Color.fromRGBO(40, 40, 40, 1)),
          textAlign: TextAlign.center),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: Text('USD \$' + this.widget.text3,
            style: TextStyle(
                fontSize: 17.0,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(40, 40, 40, 1)),
            textAlign: TextAlign.center),
      )
    ]);
  }
}
