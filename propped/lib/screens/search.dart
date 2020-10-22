import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/widgets/customAppBar.dart';

class MySearch extends StatefulWidget {
  @override
  _Search createState() => _Search();
}

class _Search extends State<MySearch> {
  var _controller = TextEditingController();
  var _visibleRemove = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        showArrow: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 100.0, 0.0, 30.0),
            child: Text(
              "Search",
              style: TextStyle(
                  fontSize: 35.0,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(40, 40, 40, 1)),
            ),
          ),
          Theme(
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
                          color: Color.fromRGBO(30, 30, 30, 1), width: 4.0),
                      borderRadius: BorderRadius.zero),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(30, 30, 30, 1), width: 3.0),
                      borderRadius: BorderRadius.zero),
                  hintText: 'Products, designers and all'),
            ),
          )
        ],
      ),
    );
  }
}
