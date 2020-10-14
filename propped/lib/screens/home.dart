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
      backgroundColor: Colors.white,
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
              left: 15.0, top: 25.0, bottom: 15.0, right: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Holiday sale",
                  style: TextStyle(
                      fontSize: 20.0,
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
          height: 310,
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
                                  repeat: ImageRepeat.noRepeat
                              )
                          ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              right: 10,
                              top: 10,
                              child: Icon(Icons.star_border, size: 30,),
                            ),
                          ]
                        )
                      ),
                      Container(
                        height: 80,
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
              left: 15.0, top: 50.0, bottom: 15.0, right: 15.0),
          child: Text("This week's highlight",
              style: TextStyle(
                  fontSize: 20.0, height: 1.35, fontWeight: FontWeight.bold)),
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
        Container()
      ],
    ));
  }
}
