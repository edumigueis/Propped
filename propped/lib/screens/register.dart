import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/screens/preference.dart';

class MyRegister extends StatefulWidget {
  MyRegister({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
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
                  "Register",
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
                      "Name:",
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
                        hintText: 'Enter your name'),
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
                  Stack(
                    alignment: Alignment.centerRight,
                    children: <Widget>[
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
                          obscureText: _obscureText),
                      IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () {
                          _toggle();
                        },
                      ),
                    ],
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
                      MaterialPageRoute(
                          builder: (context) => MyPreference()),
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  color: Color.fromARGB(255, 30, 30, 30),
                  child: Text('REGISTER',
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
