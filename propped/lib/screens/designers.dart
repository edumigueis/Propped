import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/screens/store.dart';
import 'package:propped/utils/Constants.dart';
import 'package:propped/models/Designers.dart';
import 'package:propped/widgets/customAppBar.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MyDesigners extends StatefulWidget {
  MyDesigners({Key key}) : super(key: key);

  @override
  MyDesignersState createState() => MyDesignersState();
}

class MyDesignersState extends State<MyDesigners> {
  Future<List<Designers>> fetchDesigner() async {
    final response = await http.get('http://' + Constants.serverIP + '/stores');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values = new List<dynamic>();
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            designers.add(Designers.fromJson(map));
          }
        }
      }
      if (this.mounted) setState(() {});
      return designers;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load designer');
    }
  }

  List<Designers> designers = new List<Designers>();

  @override
  void initState() {
    super.initState();
    fetchDesigner();
  }

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    var _visibleRemove = Colors.transparent;
    return Scaffold(
      appBar: CustomAppBar(
        showArrow: true,
        title: "Designers",
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: Theme(
              data: ThemeData(primaryColor: Color.fromRGBO(30, 30, 30, 1)),
              isMaterialAppTheme: false,
              child: TextField(
                onSubmitted: (String key) => {
                  if (key.trim() == "") {} else {debugPrint(key)}
                },
                onChanged: (String str) => {
                  if (str == "")
                    setState(() => {_visibleRemove = Colors.transparent})
                  else
                    setState(
                        () => {_visibleRemove = Color.fromRGBO(30, 30, 30, 1)})
                },
                controller: _controller,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: CupertinoColors.systemGrey5,
                    suffixIcon: IconButton(
                      onPressed: () => {
                        _controller.clear(),
                        setState(() => {_visibleRemove = Colors.transparent})
                      },
                      icon: Icon(
                        Icons.clear,
                        color: _visibleRemove,
                      ),
                    ),
                    prefixIcon: Icon(Icons.search),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(150, 150, 150, 1),
                            width: 2.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    hintText: 'Search designers and stores'),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            physics: new BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 15),
            itemCount: designers.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyStore(id: designers[index].getId())),
                        )
                      },
                  child: () {
                    if (index != 0) {
                      if (designers[index].getName()[0] !=
                          designers[index - 1].getName()[0]) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 70,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Text(
                                  designers[index].getName()[0],
                                  style: TextStyle(
                                      fontSize: 21.0,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(40, 40, 40, 1)),
                                ),
                              ),
                            ),
                            Container(
                              height: 70,
                              decoration: new BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                          color: Colors.black26))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      designers[index].getName(),
                                      style: TextStyle(
                                          fontSize: 21.0,
                                          fontFamily: 'Ubuntu',
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(40, 40, 40, 1)),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color.fromRGBO(30, 30, 30, 1),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    }
                    return Container(
                      height: 70,
                      decoration: new BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.black26))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              designers[index].getName(),
                              style: TextStyle(
                                  fontSize: 21.0,
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(40, 40, 40, 1)),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Color.fromRGBO(30, 30, 30, 1),
                            )
                          ],
                        ),
                      ),
                    );
                  }());
            },
          ))
        ],
      ),
    );
  }
}
