import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/screens/home.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:propped/utils/Constants.dart';

class MyLogin extends StatefulWidget {
  MyLogin({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool login = false;
  bool isButtonEnabled = false;
  String msg = "";
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  bool isLoginValid(String email, String pass) {
    if (email.trim() == "" || pass.trim() == "")
      return false;
    else {
      loginVerified();
      if (this.login == true) {
        debugPrint("aaaaaaaaaaaaaaaaaaa");
        return true;
      }
    }
    return false;
  }

  bool isEmpty() {
    if (passController.text.trim() == "" || emailController.text.trim() == "")
      setState(() {
        isButtonEnabled = false;
      });
    else
      setState(() {
        isButtonEnabled = true;
      });

    return isButtonEnabled;
  }

  void loginVerified() async {
    await verifyLogin().then((isValid) => {this.login = isValid});
  }

  Future<bool> verifyLogin() async {
    final response = await http
        .get('http://' + Constants.serverIP + '/users/login/'+this.emailController.text+'/'+ this.passController.text);

    if (response.statusCode == 200) {
      var session = FlutterSession();
      await session.set("id", 9);
      this.login = true;
      return Future<bool>.value(true);
    } else {
      this.login = false;
      return Future<bool>.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    onChanged: (val) => {isEmpty()},
                    controller: emailController,
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
                      onChanged: (val) => {isEmpty()},
                      controller: passController,
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
                    if (isButtonEnabled == true) {
                      bool loginRes = isLoginValid(
                          emailController.text, passController.text);
                      if (!loginRes) {
                        debugPrint("hey boo");
                        setState(() {
                          this.msg = "The email or password aren't correct.";
                        });
                      } else if (loginRes) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyHome()),
                        );
                      }
                    } else
                      return;
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  color: () {
                    if (isButtonEnabled == true)
                      return Color.fromARGB(255, 30, 30, 30);
                    else
                      return Color.fromARGB(230, 30, 30, 30);
                  }(),
                  child: Text('LOGIN',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(240, 240, 240, 1)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: Text("$msg",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(237, 67, 35, 1))),
          )
        ],
      )),
    );
  }
}
