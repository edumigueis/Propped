import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/utils/Designers.dart';
import 'package:propped/widgets/customAppBar.dart';

class MyDesigners extends StatefulWidget {
  MyDesignersState createState() => MyDesignersState();
}

class MyDesignersState extends State<MyDesigners> {
  List<Designers> designers = [
    new Designers("aba", "A BATHING APE"),
    new Designers("aba", "A COLD WALL"),
    new Designers("aba", "Chanel"),
    new Designers("aba", "Camo"),
    new Designers("aba", "Louis Vuitton"),
    new Designers("aba", "Renner"),
    new Designers("aba", "Ray Bun"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showArrow: true),
      body: Column(
        children: [
          Container(),
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
                              builder: (context) => MyDesigners()),
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
