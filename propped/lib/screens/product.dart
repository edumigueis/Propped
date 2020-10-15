import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:propped/widgets/customAppBar.dart';
import 'package:propped/widgets/menu.dart';

class MyProduct extends StatefulWidget {
  MyProduct({Key key}) : super(key: key);

  @override
  _MyProductState createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(showArrow: true),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.only(top: 0),
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              height: 500,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(milliseconds: 14000),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal
            ),
            items: [
              "https://cdn-images.farfetch-contents.com/15/57/78/62/15577862_28040975_1000.jpg",
              "https://cdn-images.farfetch-contents.com/15/57/78/62/15577862_28040977_1000.jpg",
              "https://cdn-images.farfetch-contents.com/15/57/78/62/15577862_28037975_1000.jpg",
              "https://cdn-images.farfetch-contents.com/15/57/78/62/15577862_28037978_1000.jpg"
            ].map((i) {
              // guardar objetos em cada uma das posições do vetor e acessar os campos no builder
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "$i"),
                            fit: BoxFit.cover,
                            repeat: ImageRepeat.noRepeat),
                      ),);
                },
              );
            }).toList(),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              children: <Widget>[
                Text(
                  "Balmain",
                  style: TextStyle(
                      fontSize: 21.0,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Moletom com zíper e capuz",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Ubuntu',
                      height: 1.6,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "R\$15.096",
                    style: TextStyle(
                      fontSize: 19.0,
                      fontFamily: 'Ubuntu',
                      height: 2.2,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "12 x R\$1.258,00",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Ubuntu',
                      height: 1.6,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: MyMenu(
        meIcon: CupertinoIcons.person,
        searchIcon: CupertinoIcons.search,
        homeIcon: CupertinoIcons.home,
        wishlistIcon: Icons.star_border,),
    );
  }
}
