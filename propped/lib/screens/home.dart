import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/utils/sliderItem.dart';
import 'package:propped/utils/stringExtension.dart';
import 'package:propped/widgets/customAppBar.dart';
import 'package:propped/widgets/menu.dart';

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
                  new SliderItem("The shirt", "shirts", 1.00),
                  new SliderItem("The shirt", "shirts", 2.00),
                  new SliderItem("The shirt", "shirts", 3.00),
                  new SliderItem("The shirt", "shirts", 4.00),
                  new SliderItem("The shirt", "shirts", 5.00)
                ].map((i) {
                  // guardar objetos em cada uma das posições do vetor e acessar os campos no builder
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://cea.vteximg.com.br/arquivos/ids/15801927/T-Shirt-Feminina-Mindset-Pessoas-Manga-Curta-Decote-Redondo-Off-White-9965361-Off_White_1.jpg?v=637365113743730000"),
                                fit: BoxFit.cover,
                                repeat: ImageRepeat.noRepeat),
                          ),
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: 30.0, top: 90.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(i.getCategory().capitalize(),
                                    style: TextStyle(fontSize: 16.0)),
                                Text(i.getName(),
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        height: 1.3)),
                                Text("\$" + i.getPrice().toString(),
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        height: 1.35,
                                        fontWeight: FontWeight.w600)),
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
                            fontSize: 21.0,
                            height: 1.35,
                            fontWeight: FontWeight.bold)),
                    Text("SEE ALL",
                        style: TextStyle(
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
              Container(
                margin: const EdgeInsets.only(
                    left: 15.0, top: 50.0, bottom: 20.0, right: 15.0),
                child: Text("This week's highlights",
                    style: TextStyle(
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
                                          fontSize: 21.0,
                                          height: 2,
                                          fontWeight: FontWeight.bold)),
                                  Text("New York style, but fresh-minded.",
                                      style: TextStyle(
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
                            fontSize: 21.0,
                            height: 1.35,
                            fontWeight: FontWeight.bold)),
                    Text("SEE ALL",
                        style: TextStyle(
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
                            fontSize: 21.0,
                            height: 1.35,
                            fontWeight: FontWeight.bold)),
                    Text("SEE ALL",
                        style: TextStyle(
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
        wishlistIcon: Icons.star_border,
      ),
    );
  }
}
