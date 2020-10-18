import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:propped/screens/home.dart';
import 'package:propped/utils/modal.dart';
import 'package:propped/widgets/customAppBar.dart';
import 'package:propped/widgets/menu.dart';

class MyProduct extends StatefulWidget {
  @override
  _MyProductState createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  int _activeMeterIndex;
  String sizeOption = 'Select your size';
  var _availableSizeColor = Colors.black38;

  _closeModal(int index) {
    Navigator.of(context).pop();
    debugPrint(index.toString());

    setState(() {
      switch (index) {
        case 0:
          {
            sizeOption = "XXS";
          }
          break;
        case 1:
          {
            sizeOption = "XS";
          }
          break;
        case 2:
          {
            sizeOption = "S";
          }
          break;
        case 3:
          {
            sizeOption = "M";
          }
          break;
        case 4:
          {
            sizeOption = "L";
          }
          break;
        case 5:
          {
            sizeOption = "XL";
          }
          break;
        case 6:
          {
            sizeOption = "XXL";
          }
          break;
      }
      _availableSizeColor = Color.fromRGBO(30, 30, 30, 1);
    });
  }

  void _showModal() {
    showMaterialModalBottomSheet(
        expand: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context, ScrollController sc) => Material(
                child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text('XXS'),
                    leading: Icon(CupertinoIcons.minus_circled),
                    onTap: () => _closeModal(0),
                  ),
                  ListTile(
                    title: Text('XS'),
                    leading: Icon(Icons.content_copy),
                    onTap: () => _closeModal(1),
                  ),
                  ListTile(
                    title: Text('S'),
                    onTap: () => _closeModal(2),
                  ),
                  ListTile(
                    title: Text('M'),
                    onTap: () => _closeModal(3),
                  ),
                  ListTile(
                    title: Text('L'),
                    onTap: () => _closeModal(4),
                  ),
                  ListTile(
                    title: Text('XL'),
                    leading: Icon(CupertinoIcons.add),
                    onTap: () => _closeModal(5),
                  ),
                  ListTile(
                    title: Text('XXL'),
                    leading: Icon(CupertinoIcons.add_circled),
                    onTap: () => _closeModal(6),
                  )
                ],
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RawMaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHome()),
          )
        },
        child: Container(
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Color.fromARGB(255, 30, 30, 30)),
            margin: EdgeInsets.only(left: 15, right: 15),
            height: 50,
            width: MediaQuery.of(context).size.width - 60,
            child: Center(
              child: Text(
                "ADD TO BAG",
                style: new TextStyle(
                    fontSize: 15,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(240, 240, 240, 1)),
                textAlign: TextAlign.center,
              ),
            )),
      ),
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(showArrow: true),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(0),
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
                scrollDirection: Axis.horizontal),
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
                          image: NetworkImage("$i"),
                          fit: BoxFit.cover,
                          repeat: ImageRepeat.noRepeat),
                    ),
                  );
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
          ),
          Container(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Colors.black26),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              margin: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 30),
              child: GestureDetector(
                onTap: _showModal,
                child: Container(
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("$sizeOption",
                                style: TextStyle(
                                    fontSize: 19.0,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.w500,
                                    color: _availableSizeColor)),
                            Icon(
                              CupertinoIcons.down_arrow,
                              color: Colors.black87,
                            )
                          ],
                        ))),
              )),
          ListView.builder(
              padding: EdgeInsets.only(top: 0, bottom: 100),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: 4,
              itemBuilder: (BuildContext context, int i) {
                return Container(
                  color: Colors.white,
                  /*decoration: new BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1, color: Colors.white70),
                        bottom: BorderSide(width: 1, color: Colors.white70)),
                  ),*/
                  margin: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
                  child: new ExpansionPanelList(
                    expansionCallback: (int index, bool status) {
                      setState(() {
                        _activeMeterIndex = _activeMeterIndex == i ? null : i;
                      });
                    },
                    children: [
                      new ExpansionPanel(
                        canTapOnHeader: true,
                        isExpanded: _activeMeterIndex == i,
                        headerBuilder:
                            (BuildContext context, bool isExpanded) =>
                                new Container(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    alignment: Alignment.centerLeft,
                                    child: new Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0,
                                          right: 5.0,
                                          top: 15,
                                          bottom: 15),
                                      child: Text(
                                        (() {
                                          switch (i) {
                                            case 0:
                                              return "Description";
                                              break;
                                            case 1:
                                              return "Size & Fit";
                                              break;
                                            case 2:
                                              return "Composition & Care";
                                              break;
                                            case 3:
                                              return "Designer - Balmain";
                                              break;
                                          }
                                          return "Description";
                                        })(),
                                        style: new TextStyle(
                                            fontSize: 22.0,
                                            fontFamily: 'Ubuntu',
                                            height: 1.6,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                        body: new Container(
                          child: new Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 0, bottom: 20),
                              child: Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ex lorem, elementum eu maximus et, accumsan eget sapien. Ut commodo eu dolor nec suscipit.',
                                style: new TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Ubuntu',
                                    height: 1,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
      bottomNavigationBar: MyMenu(
        meIcon: CupertinoIcons.person,
        searchIcon: CupertinoIcons.search,
        homeIcon: CupertinoIcons.home,
        wishlistIcon: Icons.star_border,
      ),
    );
  }
}
