import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:propped/utils/Constants.dart';
import 'package:propped/models/User.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'home.dart';

class MyPreference extends StatefulWidget {
  MyPreference({Key key, @required User user})
      : this.user = user,
        super(key: key);

  final User user;

  @override
  _MyPreferenceState createState() => _MyPreferenceState();
}

class _MyPreferenceState extends State<MyPreference> {
  Future<User> register(String preference, BuildContext ctx) async {
    final http.Response response = await http.post(
      'http://' + Constants.serverIP + '/users',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name_user': widget.user.name,
        'email_user': widget.user.email,
        'pass_user': widget.user.password,
        'gender_user': 'Not Informed',
        'birth_date_user': '1/1/1999',
        'registry_user': 'Not Informed',
        'phone_user': 'Not Informed',
        'image_user': 'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/109852763/original/e9f05328b042adf5ef076bf637296a484a609342/create-trendy-abstract-geometric-pattern-on-light-background.jpg',
        'preference_user': preference,
      }),
    );
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      User user;
      List<dynamic> values = new List<dynamic>();
      values = json.decode(response.body);
      if (values.length > 0) {
        if (values[0] != null) {
          Map<String, dynamic> map = values[0];
          user = User.fromJson(map);
        }
      }
      var session = FlutterSession();
      await session.set("id", user.id);
      redirectToHome(ctx);
      return user;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load user');
    }
  }

  void redirectToHome(BuildContext redirectTarget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHome()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
        child: Center(
          child: ListView(
            physics: new BouncingScrollPhysics(),
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
                              onPressed: () {
                                register("ALL", context);
                              },
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
                              onPressed: () {
                                register("MEN", context);
                              },
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
                              onPressed: () {
                                register("WOMEN", context);
                              },
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
                              onPressed: () {
                                register("GENDERLESS", context);
                              },
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
