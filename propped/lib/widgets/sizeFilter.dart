import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void ValueRetriever(String val);

class SizeFilter extends StatefulWidget {
  SizeFilter({Key ky, this.callback});

  final ValueRetriever callback;

  @override
  SizeFilterState createState() => SizeFilterState(callback);
}

class SizeFilterState extends State<SizeFilter> {
  final ValueRetriever cb;

  SizeFilterState(this.cb);

  List<String> sizes = ["All", "One Size", "XXXS", "XXS", "XS", "S", "M", "L", "XL", "XXL", "XXXL", "XXXXL" ];

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: new BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 60),
      itemCount: sizes.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            onTap: () {
              setState(() {
                selected = index;
              });
              cb(sizes[index]);
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
                    Text(
                      sizes[index],
                      style: TextStyle(fontSize: 17),
                    ),
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
    );
  }
}
