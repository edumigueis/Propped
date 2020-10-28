import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/utils/AdvancedColor.dart';

typedef void ValueRetriever(String val);

class ColorFilter extends StatelessWidget {
  final ValueRetriever callback;

  ColorFilter({this.callback});

  List<AdvancedColor> colors = [
    new AdvancedColor(Color.fromRGBO(228, 140, 115, 1), "Abricot"),
    new AdvancedColor(Colors.black, "Black"),
    new AdvancedColor(Colors.blue, "Blue"),
    new AdvancedColor(Colors.brown, "Brown"),
    new AdvancedColor(Color.fromRGBO(206, 177, 128, 1), "Ecru"),
    new AdvancedColor(Colors.lightGreenAccent, "Green"),
    new AdvancedColor(Colors.grey, "Grey"),
    new AdvancedColor(Color.fromRGBO(180, 132, 180, 1), "Lilac"),
    new AdvancedColor(Color.fromRGBO(255, 10, 144, 1), "Magenta"),
    new AdvancedColor(Color.fromRGBO(225, 198, 153, 1), "Neutrals"),
    new AdvancedColor(Color.fromRGBO(255, 150, 0, 1), "Orange"),
    new AdvancedColor(Color.fromRGBO(160, 32, 240, 1), "Purple"),
    new AdvancedColor(Colors.red, "Red"),
    new AdvancedColor(Colors.cyanAccent, "Red"),
    new AdvancedColor(Colors.white70, "White"),
    new AdvancedColor(Colors.yellow, "Yellow"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            onTap: () {
              callback("str");
            },
            child: Container(
              height: 60,
              decoration: new BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1.0,
                          style: BorderStyle.solid,
                          color: Colors.black26))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 20,
                      height: 20,
                      color: colors[index].getColor(),
                    ),
                    Text(
                      colors[index].getName(),
                      style: TextStyle(fontSize: 17),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromRGBO(30, 30, 30, 1),
                    )
                  ],
                ),
              ),
            ));
      },
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
    );
  }
}
