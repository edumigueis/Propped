import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void ValueRetriever(String val);

class OccasionFilter extends StatefulWidget {
  OccasionFilter({Key ky, this.callback});

  final ValueRetriever callback;

  @override
  OccasionFilterState createState() => OccasionFilterState(callback);
}

class OccasionFilterState extends State<OccasionFilter> {
  final ValueRetriever cb;

  OccasionFilterState(this.cb);

  List<String> occasions = ["All","Formal", "Informal", "Intimate"];

  int selected = 1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 60),
      itemCount: occasions.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            onTap: () {
              setState(() {
                selected = index;
              });
              cb(occasions[index]);
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
                        occasions[index],
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
      physics: ClampingScrollPhysics(),
    );
  }
}
