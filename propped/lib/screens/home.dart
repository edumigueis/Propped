import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/utils/sliderItem.dart';
import 'package:propped/utils/stringExtension.dart';
import 'package:propped/widgets/customAppBar.dart';
import 'package:propped/widgets/menu.dart';
import 'package:propped/widgets/shadowText.dart';

class MyHome extends StatefulWidget {
  MyHome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(showArrow: false),
      backgroundColor: Colors.white,
      body: NotificationListener(
          onNotification: (v) {
            if (v is ScrollUpdateNotification) {
              DragUpdateDetails dd = v.dragDetails;
              if (top > -100 && top < 100) {
                if (dd != null) {
                  if (dd.delta.dx == 0) {
                    if ((v.scrollDelta < 15 && v.scrollDelta > 0) ||
                        (v.scrollDelta < 0 && v.scrollDelta > -15))
                      setState(() => top -= v.scrollDelta / 5);
                  }
                }
              }
              if (top > 100) top -= 60;
              if (top < -100) top += 60;
            }
            return true;
          },
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: 0.0),
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
                  scrollDirection: Axis.horizontal,
                ),
                items: [
                  new SliderItem("Jeans jacket", "Balenciaga", 1200.00,
                      "https://cdn-images.farfetch-contents.com/15/92/10/40/15921040_ba827e39-3af3-494e-8d96-1aa07c3c5701_1000.jpg"),
                  new SliderItem("CK top", "Calvin Klein", 4500.00,
                      "https://cdn.cnn.com/cnnnext/dam/assets/200626154625-01-jari-jones-calvin-klein-super-169.jpg"),
                  new SliderItem("Cargo pants", "Hugo Boss", 350.00,
                      "https://cdn-images.farfetch-contents.com/15/13/94/04/15139404_26260949_480.jpg"),
                  new SliderItem("Flair ribcage pants ", "shirts", 400.00,
                      "https://cdn-images.farfetch-contents.com/14/05/85/86/14058586_18824807_1000.jpg"),
                  new SliderItem("Kartman suit", "Hugo Boss", 4900.90,
                      "https://cdn-static.farfetch-contents.com/cms-cm/br/media/1603820/data/05ad44e1c19ec1f2e5a3960e1a95ae32.jpg?ratio=1x1_two-columns&minWidth=637")
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(i.getImage()),
                                fit: BoxFit.cover,
                                repeat: ImageRepeat.noRepeat),
                          ),
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: 30.0, top: 90.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ShadowText(
                                  i.getCategory().capitalize(),
                                  style: TextStyle(
                                    color: Color.fromRGBO(30, 30, 30, 1),
                                    fontSize: 16.0,
                                    fontFamily: 'Ubuntu',
                                  ),
                                  color: Colors.white12,
                                  opacity: 0.3,
                                ),
                                ShadowText(
                                  i.getName(),
                                  style: TextStyle(
                                      color: Color.fromRGBO(30, 30, 30, 1),
                                      fontSize: 20.0,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.bold,
                                      height: 1.3),
                                  color: Colors.white12,
                                  opacity: 0.4,
                                ),
                                ShadowText(
                                  "\$" + i.getPrice().toString(),
                                  style: TextStyle(
                                      color: Color.fromRGBO(30, 30, 30, 1),
                                      fontSize: 15.0,
                                      fontFamily: 'Ubuntu',
                                      height: 1.85,
                                      fontWeight: FontWeight.w600),
                                  color: Colors.white12,
                                  opacity: 0.4,
                                ),
                              ],
                            ),
                          ));
                    },
                  );
                }).toList(),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 15.0, top: 30.0, bottom: 20.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Holiday sale",
                        style: TextStyle(
                            color: Color.fromRGBO(30, 30, 30, 1),
                            fontSize: 21.0,
                            height: 1.35,
                            fontWeight: FontWeight.bold)),
                    Text("SEE ALL",
                        style: TextStyle(
                            color: Color.fromRGBO(30, 30, 30, 1),
                            fontSize: 13.0,
                            height: 1.35,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Container(
                height: 325,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: new BouncingScrollPhysics(),
                    itemCount: 9,
                    itemBuilder: (BuildContext context, int index) {
                      return new Container(
                        width: 230.0,
                        margin: const EdgeInsets.only(left: 15.0),
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Container(
                                height: 230,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://images.asos-media.com/products/converse-x-tyler-the-creator-golf-le-fleur-one-star-trainers-in-green/9323779-1-green"),
                                        fit: BoxFit.cover,
                                        repeat: ImageRepeat.noRepeat)),
                                child: Stack(children: <Widget>[
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      child: GestureDetector(
                                        child: Icon(
                                          Icons.star_border,
                                          size: 30,
                                        ),
                                        onTap: () {
                                          debugPrint(
                                              "clicked"); //here saving favorite will be added
                                        },
                                      ),
                                    ),
                                  ),
                                ])),
                            Container(
                              height: 95,
                              width: double.infinity,
                              child: Column(
                                children: <Widget>[
                                  Text("Golf La Fleur x Converse",
                                      style: TextStyle(
                                          color: Color.fromRGBO(30, 30, 30, 1),
                                          fontSize: 16.0,
                                          height: 1.7,
                                          fontWeight: FontWeight.bold)),
                                  Text("Strain Sneekers",
                                      style: TextStyle(
                                          color: Color.fromRGBO(30, 30, 30, 1),
                                          fontSize: 18.0,
                                          height: 1.4,
                                          fontWeight: FontWeight.w500)),
                                  Text("\$50.00",
                                      style: TextStyle(
                                          color: Color.fromRGBO(30, 30, 30, 1),
                                          fontSize: 17.0,
                                          height: 1.4,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 15.0, top: 50.0, bottom: 20.0, right: 15.0),
                child: Text("This week's highlights",
                    style: TextStyle(
                        color: Color.fromRGBO(30, 30, 30, 1),
                        fontSize: 21.0,
                        height: 1.35,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                height: 480,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: new BouncingScrollPhysics(),
                    itemCount: 9,
                    itemBuilder: (BuildContext context, int index) {
                      return new Container(
                        width: MediaQuery.of(context).size.width - 60,
                        margin: const EdgeInsets.only(left: 15.0),
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 370,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://cache.net-a-porter.com/images/products/1074114/1074114_ou_2000_q80.jpg"),
                                      fit: BoxFit.cover,
                                      repeat: ImageRepeat.noRepeat)),
                            ),
                            Container(
                              height: 110,
                              width: double.infinity,
                              child: Column(
                                children: <Widget>[
                                  Text("BALENCIAGA",
                                      style: TextStyle(
                                          color: Color.fromRGBO(30, 30, 30, 1),
                                          fontSize: 21.0,
                                          height: 2,
                                          fontWeight: FontWeight.bold)),
                                  Text("New York style, but fresh-minded.",
                                      style: TextStyle(
                                          color: Color.fromRGBO(30, 30, 30, 1),
                                          fontSize: 17.0,
                                          height: 1.7,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 15.0, top: 30.0, bottom: 20.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Recommended for you",
                        style: TextStyle(
                            color: Color.fromRGBO(30, 30, 30, 1),
                            fontSize: 21.0,
                            height: 1.35,
                            fontWeight: FontWeight.bold)),
                    Text("SEE ALL",
                        style: TextStyle(
                            color: Color.fromRGBO(30, 30, 30, 1),
                            fontSize: 13.0,
                            height: 1.35,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Container(
                height: 325,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: new BouncingScrollPhysics(),
                    itemCount: 9,
                    itemBuilder: (BuildContext context, int index) {
                      return new Container(
                        width: 230.0,
                        margin: const EdgeInsets.only(left: 15.0),
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Container(
                                height: 230,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://images.asos-media.com/products/converse-x-tyler-the-creator-golf-le-fleur-one-star-trainers-in-green/9323779-1-green"),
                                        fit: BoxFit.cover,
                                        repeat: ImageRepeat.noRepeat)),
                                child: Stack(children: <Widget>[
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      child: GestureDetector(
                                        child: Icon(
                                          Icons.star_border,
                                          size: 30,
                                        ),
                                        onTap: () {
                                          debugPrint(
                                              "clicked"); //here saving favorite will be added
                                        },
                                      ),
                                    ),
                                  ),
                                ])),
                            Container(
                              height: 95,
                              width: double.infinity,
                              child: Column(
                                children: <Widget>[
                                  Text("Golf La Fleur x Converse",
                                      style: TextStyle(
                                          color: Color.fromRGBO(30, 30, 30, 1),
                                          fontSize: 16.0,
                                          height: 1.7,
                                          fontWeight: FontWeight.bold)),
                                  Text("Strain Sneekers",
                                      style: TextStyle(
                                          color: Color.fromRGBO(30, 30, 30, 1),
                                          fontSize: 18.0,
                                          height: 1.4,
                                          fontWeight: FontWeight.w500)),
                                  Text("\$50.00",
                                      style: TextStyle(
                                          color: Color.fromRGBO(30, 30, 30, 1),
                                          fontSize: 17.0,
                                          height: 1.4,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: Stack(
                  children: <Widget>[
                    new Positioned(
                      top: 0,
                      child: Container(
                        height: 600,
                        width: MediaQuery.of(context).size.width,
                        child: OverflowBox(
                            minHeight: 100,
                            maxWidth: MediaQuery.of(context).size.width,
                            child: Transform.translate(
                              offset: Offset(0.0, top),
                              child: Container(
                                height: 600,
                                width: MediaQuery.of(context).size.width,
                                decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                        image: AssetImage(
                                            'assets/images/home-edit-section.jpg'),
                                        fit: BoxFit.cover)),
                              ),
                            )),
                      ),
                    ),
                    Container(
                      height: 500,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "The Sustainable Edit",
                            style: TextStyle(
                                fontSize: 29.0,
                                height: 1.7,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Text(
                              "Checkout the sustainable outfit selection. Curated by Propped.",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  height: 1.2,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 15.0, top: 70.0, bottom: 20.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Added recently",
                        style: TextStyle(
                            color: Color.fromRGBO(30, 30, 30, 1),
                            fontSize: 21.0,
                            height: 1.35,
                            fontWeight: FontWeight.bold)),
                    Text("SEE ALL",
                        style: TextStyle(
                            color: Color.fromRGBO(30, 30, 30, 1),
                            fontSize: 13.0,
                            height: 1.35,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Container(
                height: 325,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: new BouncingScrollPhysics(),
                    itemCount: 9,
                    itemBuilder: (BuildContext context, int index) {
                      return new Container(
                        width: 230.0,
                        margin: const EdgeInsets.only(left: 15.0),
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Container(
                                height: 230,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://images.asos-media.com/products/converse-x-tyler-the-creator-golf-le-fleur-one-star-trainers-in-green/9323779-1-green"),
                                        fit: BoxFit.cover,
                                        repeat: ImageRepeat.noRepeat)),
                                child: Stack(children: <Widget>[
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      child: GestureDetector(
                                        child: Icon(
                                          Icons.star_border,
                                          size: 30,
                                        ),
                                        onTap: () {
                                          debugPrint(
                                              "clicked"); //here saving favorite will be added
                                        },
                                      ),
                                    ),
                                  ),
                                ])),
                            Container(
                              height: 95,
                              width: double.infinity,
                              child: Column(
                                children: <Widget>[
                                  Text("Golf La Fleur x Converse",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          height: 1.7,
                                          fontWeight: FontWeight.bold)),
                                  Text("Strain Sneekers",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          height: 1.4,
                                          fontWeight: FontWeight.w500)),
                                  Text("\$50.00",
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          height: 1.4,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ],
          )),
      bottomNavigationBar: MyMenu(
        meIcon: CupertinoIcons.person,
        searchIcon: CupertinoIcons.search,
        homeIcon: Icons.home,
        wishlistIcon: CupertinoIcons.heart,
      ),
    );
  }
}
