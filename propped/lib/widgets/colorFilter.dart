import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/utils/AdvancedColor.dart';

typedef void ValueRetriever(String val);

class ColorFilter extends StatefulWidget {
  ColorFilter({Key ky, this.callback});

  final ValueRetriever callback;

  @override
  ColorFilterState createState() => ColorFilterState(callback);
}

class ColorFilterState extends State<ColorFilter> {
  final ValueRetriever cb;

  ColorFilterState(this.cb);

  List<AdvancedColor> colors = [
    new AdvancedColor(Colors.transparent, "All"),
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
    new AdvancedColor(Colors.cyanAccent, "Turquoise"),
    new AdvancedColor(Colors.white70, "White"),
    new AdvancedColor(Colors.yellow, "Yellow"),
  ];

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 60),
      itemCount: colors.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            onTap: () {
              setState(() {
                selected = index;
              });
              cb(colors[index].colorName);
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
                    Row(children: <Widget>[
                      Container(
                        decoration: new BoxDecoration(
                          border: new Border.all(color: Colors.black12),
                          color: colors[index].getColor(),
                        ),
                        margin: EdgeInsets.only(right: 15),
                        width: 20,
                        height: 20,
                      ),
                      Text(
                        colors[index].getName(),
                        style: TextStyle(fontSize: 17),
                      ),
                    ]),
                    Icon(
                      () {
                        if (selected == index)
                          return Icons.check;
                        else
                          return null;
                      }(),
                      color: Color.fromRGBO(30, 30, 30, 1),
                    )
                  ],
                ),
              ),
            ));
      },
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
    );
  }
}
