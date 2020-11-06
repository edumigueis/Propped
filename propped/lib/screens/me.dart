import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/utils/Constants.dart';
import 'package:propped/widgets/customAppBar.dart';
import 'package:propped/widgets/footer.dart';
import 'package:propped/widgets/menu.dart';
import 'package:propped/models/User.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Me extends StatefulWidget {
  @override
  _Me createState() => _Me();
}

enum Preferences { All, Women, Men, Genderless }

class _Me extends State<Me> {
  Preferences _character = Preferences.All;
  List supItems = [
    "About Propped",
    "Terms and Conditions",
    "Privacy Policy",
    "Partners",
    "Guides"
  ];
  String codeUser = "4CN5M7Y897Y9834NMU085";

  Future<User> fetchUser() async {
    final response = await http
        .get('http://' + Constants.serverIP + '/users/' + this.codeUser);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values = new List<dynamic>();
      values = json.decode(response.body);
      if (values.length > 0) {
        if (values[0] != null) {
          Map<String, dynamic> map = values[0];
          this.user = User.fromJson(map);
          this._character = getPreference(this.user);
        }
      }
      if (this.mounted) setState(() {});
      return user;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load user');
    }
  }

  Preferences getPreference(User usr) {
    debugPrint(usr.preference);
    switch (usr.preference.toUpperCase()) {
      case "ALL":
        {
          return Preferences.All;
        }
        break;
      case "MEN":
        {
          return Preferences.Men;
        }
        break;
      case "WOMEN":
        {
          return Preferences.Women;
        }
        break;
      case "GENDERLESS":
        {
          return Preferences.Genderless;
        }
        break;
    }
    return Preferences.All;
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  User user = new User(name: "Error", email: "Failed to load");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                color: CupertinoColors.systemGrey5,
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
                          Text(this.user.name,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(40, 40, 40, 1)),
                              textAlign: TextAlign.left),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              this.user.email,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60)),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://cdn4.iconfinder.com/data/icons/square-world-flags/180/flag_us_america_united_states_square-512.png"))),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              "United States of America (\$ USD)",
                              style: TextStyle(fontSize: 16.7),
                            ),
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
                            value: Preferences.All,
                            groupValue: _character,
                            onChanged: (Preferences value) {
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
                        title: const Text('Women'),
                        leading: Transform.scale(
                          scale: 1.4,
                          child: Radio(
                            activeColor: Color.fromRGBO(30, 30, 30, 1),
                            value: Preferences.Women,
                            groupValue: _character,
                            onChanged: (Preferences value) {
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
                            value: Preferences.Men,
                            groupValue: _character,
                            onChanged: (Preferences value) {
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
                            value: Preferences.Genderless,
                            groupValue: _character,
                            onChanged: (Preferences value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("Support",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(40, 40, 40, 1))),
                    ),
                    ListView.builder(
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 60,
                          decoration: new BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      color: Colors.black26))),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  supItems[index],
                                  style: TextStyle(fontSize: 17),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color.fromRGBO(30, 30, 30, 1),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                    )
                  ],
                ),
              ),
              Footer()
            ],
          )),
      bottomNavigationBar: MyMenu(
        meIcon: CupertinoIcons.person_solid,
        searchIcon: CupertinoIcons.search,
        homeIcon: CupertinoIcons.home,
        wishlistIcon: Icons.star_border,
      ),
    );
  }
}
