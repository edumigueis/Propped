import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/utils/sliderItem.dart';
import 'package:propped/utils/stringExtension.dart';

class MyHome extends StatefulWidget {
  MyHome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
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
            // guardar objetos json em cada uma das posições do vetor e fazer o map para acessar os campos no builder
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
                      margin: const EdgeInsets.only(left: 30.0, top: 90.0),
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
              left: 15.0, top: 15.0, bottom: 15.0, right: 15.0),
          child: Text("Holiday sale",
              style: TextStyle(
                  fontSize: 20.0, height: 1.35, fontWeight: FontWeight.bold)),
        ),
        Container(
          height: 200,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: new BouncingScrollPhysics(),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return new Container(
                  width: 200.0,
                  margin: const EdgeInsets.only(left: 15.0),
                  color: Colors.red,
                );
              }),
        ),
        Container(
          margin: const EdgeInsets.only(
              left: 15.0, top: 50.0, bottom: 15.0, right: 15.0),
          child: Text("This week's highlight",
              style: TextStyle(
                  fontSize: 20.0, height: 1.35, fontWeight: FontWeight.bold)),
        ),
        Container(
          height: 390,
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
                        height: 340,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://cache.net-a-porter.com/images/products/1074114/1074114_ou_2000_q80.jpg"),
                              fit: BoxFit.cover,
                              repeat: ImageRepeat.noRepeat
                            )
                        ),
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: Column(
                          children: <Widget>[
                            Text("Thyg Collection",
                                style: TextStyle(
                                    fontSize: 20.0, height: 1.35, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
        )
      ],
    ));
  }
}
