import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/widgets/customAppBar.dart';

class Me extends StatefulWidget {
  @override
  _Me createState() => _Me();
}

enum SingingCharacter { All, Woman, Men, Genderless }

class _Me extends State<Me> {
  SingingCharacter _character = SingingCharacter.Woman;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(showArrow: false),
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
                  child: Text(
                    "Me",
                    style: TextStyle(
                        fontSize: 35.0,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(40, 40, 40, 1)),
                  ),
                ),
                Container(
                  color: Colors.black12,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  height: 100,
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 70,
                        width: 70,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://images.pexels.com/photos/2101839/pexels-photo-2101839.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"))),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Alana Megid",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(40, 40, 40, 1)),
                                textAlign: TextAlign.left),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Lorem Ipsum Dolor Sit amet",
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromRGBO(40, 40, 40, 1)),
                                textAlign: TextAlign.left,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text("Location",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(40, 40, 40, 1))),
                      ),
                      Container(
                        decoration: new BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                    color: Colors.black26))),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(60)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://images.pexels.com/photos/2101839/pexels-photo-2101839.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"))),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              child: Text("United States of America (\$ USD)", style: TextStyle(
                                fontSize: 16.7
                              ),),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("Shop preference",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(40, 40, 40, 1))),
                    ),
                    Container(
                      decoration: new BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.black26))),
                      child: ListTile(
                          title: const Text('All'),
                          leading: Transform.scale(
                            scale: 1.4,
                            child: Radio(
                              activeColor: Color.fromRGBO(30, 30, 30, 1),
                              value: SingingCharacter.All,
                              groupValue: _character,
                              onChanged: (SingingCharacter value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          )),
                    ),
                    Container(
                      decoration: new BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.black26))),
                      child: ListTile(
                          title: const Text('Woman'),
                          leading: Transform.scale(
                            scale: 1.4,
                            child: Radio(
                              activeColor: Color.fromRGBO(30, 30, 30, 1),
                              value: SingingCharacter.Woman,
                              groupValue: _character,
                              onChanged: (SingingCharacter value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          )),
                    ),
                    Container(
                      decoration: new BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.black26))),
                      child: ListTile(
                          title: const Text('Men'),
                          leading: Transform.scale(
                            scale: 1.4,
                            child: Radio(
                              activeColor: Color.fromRGBO(30, 30, 30, 1),
                              value: SingingCharacter.Men,
                              groupValue: _character,
                              onChanged: (SingingCharacter value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          )),
                    ),
                    Container(
                      decoration: new BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.black26))),
                      child: ListTile(
                          title: const Text('Genderless'),
                          leading: Transform.scale(
                            scale: 1.4,
                            child: Radio(
                              activeColor: Color.fromRGBO(30, 30, 30, 1),
                              value: SingingCharacter.Genderless,
                              groupValue: _character,
                              onChanged: (SingingCharacter value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            )));
  }
}
