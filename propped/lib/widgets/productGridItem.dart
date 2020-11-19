import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/screens/product.dart';

class ProductGridItem extends StatefulWidget {
  ProductGridItem(
      {Key key,
      @required this.text1,
      @required this.text2,
      @required this.text3,
      @required this.image,
      @required this.isFavorite,
      @required this.redirectCode})
      : super(key: key);

  String text1;
  String text2;
  String text3;
  String image;
  bool isFavorite;
  String redirectCode;

  @override
  ProductGridItemState createState() => ProductGridItemState();
}

class ProductGridItemState extends State<ProductGridItem> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      GestureDetector(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyProduct(
                      code: widget.redirectCode,
                    )),
          )
        },
        child: Container(
            margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 2,
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(widget.image)),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => {
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
      Text(this.widget.text2,
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
