import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPreference extends StatefulWidget {
  MyPreference({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyPreferenceState createState() => _MyPreferenceState();
}

class _MyPreferenceState extends State<MyPreference> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
        child: Center(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40.0, 0, 20.0),
                child: Text(
                  "Preference",
                  style: TextStyle(
                      fontSize: 35.0,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(40, 40, 40, 1)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 14.5, 0, 14.5),
                child: Stack(
                  children: <Widget>[
                    new Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/preference-1.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    new Center(
                      heightFactor: 3,
                      child: ButtonTheme(
                          minWidth: 130,
                          height: 50,
                          child: RaisedButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              color: Color.fromARGB(255, 250, 250, 250),
                              child: Text('Shop All',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(25, 25, 25, 1))))),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 14.5, 0, 14.5),
                child: Stack(
                  children: <Widget>[
                    new Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/preference-2.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    new Center(
                      heightFactor: 3,
                      child: ButtonTheme(
                          minWidth: 130,
                          height: 50,
                          child: RaisedButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              color: Color.fromARGB(255, 250, 250, 250),
                              child: Text('Shop Men',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(25, 25, 25, 1))))),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 14.5, 0, 14.5),
                child: Stack(
                  children: <Widget>[
                    new Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/preference-3.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    new Center(
                      heightFactor: 3,
                      child: ButtonTheme(
                          minWidth: 130,
                          height: 50,
                          child: RaisedButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              color: Color.fromARGB(255, 250, 250, 250),
                              child: Text('Shop Women',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(25, 25, 25, 1))))),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 14.5, 0, 14.5),
                child: Stack(
                  children: <Widget>[
                    new Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/preference-4.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    new Center(
                      heightFactor: 3,
                      child: ButtonTheme(
                          minWidth: 130,
                          height: 50,
                          child: RaisedButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              color: Color.fromARGB(255, 250, 250, 250),
                              child: Text('Shop Genderless',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(25, 25, 25, 1))))),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
