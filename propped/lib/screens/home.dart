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
            autoPlayInterval: Duration(milliseconds: 15000),
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
        child: Text("Holiday sale"),
      ),
      Container(
        height: 200,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              width: 160.0,
              color: Colors.red,
            ),
            Container(
              width: 160.0,
              color: Colors.blue,
            ),
            Container(
              width: 160.0,
              color: Colors.green,
            ),
          ],
        ),
      )

      ],
    ));
  }
}
