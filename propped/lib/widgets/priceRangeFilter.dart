import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:propped/utils/PriceRange.dart';

typedef void ValueRetriever(PriceRange val);

class PriceRangeFilter extends StatefulWidget {
  PriceRangeFilter({Key ky, this.callback});

  final ValueRetriever callback;

  @override
  PriceRangeFilterState createState() => PriceRangeFilterState(callback);
}

class PriceRangeFilterState extends State<PriceRangeFilter> {
  final ValueRetriever cb;

  PriceRangeFilterState(this.cb);

  int min = 0;
  int max = 10000000;

  final maxController = TextEditingController();
  final minController = TextEditingController();

  PriceRange range = new PriceRange(0, 10000000);

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    cb(new PriceRange(min, max));
    maxController.dispose();
    minController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 100),
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(Icons.attach_money),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    width: MediaQuery.of(context).size.width / 3.3,
                    child: TextField(
                      onChanged: (value) =>
                          {min = int.parse(minController.text)},
                      controller: minController,
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
                          hintText: 'Min'),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.attach_money),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    width: MediaQuery.of(context).size.width / 3.3,
                    child: TextField(
                      onChanged: (value) =>
                          {max = int.parse(maxController.text)},
                      controller: maxController,
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
                          hintText: 'Max'),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () => {min = 0, max = 10000000},
          child: Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width - (3*MediaQuery.of(context).size.width / 3.3), top: 18),
            child: Text(
              "Clear",
              style: new TextStyle(fontSize: 18, color: Colors.black38),
            ),
          ),
        )
      ],
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
    );
  }
}
