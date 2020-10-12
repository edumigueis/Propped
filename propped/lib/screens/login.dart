import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/screens/home.dart';
import 'package:propped/screens/wishlist.dart';

class MyLogin extends StatefulWidget {
  MyLogin({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 20.0),
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 35.0,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(40, 40, 40, 1)),
                ),
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "E-mail:",
                      style: TextStyle(
                          fontSize: 19.0,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(40, 40, 40, 1)),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(30, 30, 30, 1),
                                width: 4.0),
                            borderRadius: BorderRadius.zero),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(30, 30, 30, 1),
                                width: 3.0),
                            borderRadius: BorderRadius.zero),
                        hintText: 'Enter your email'),
                  ),
                ],
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Password:",
                      style: TextStyle(
                          fontSize: 19.0,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(40, 40, 40, 1)),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  TextField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(30, 30, 30, 1),
                                  width: 4.0),
                              borderRadius: BorderRadius.zero),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(30, 30, 30, 1),
                                  width: 3.0),
                              borderRadius: BorderRadius.zero),
                          hintText: 'Enter your password'),
                      obscureText: true),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    alignment: Alignment(1, 0),
                    child: Text("Forgot your password?",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(40, 40, 40, 1)),
                        textAlign: TextAlign.right),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHome()),
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  color: Color.fromARGB(255, 30, 30, 30),
                  child: Text('LOGIN',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(240, 240, 240, 1)))),
            ),
          )
        ],
      )),
    );
  }
}
