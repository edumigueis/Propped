import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/utils/Designers.dart';
import 'package:propped/widgets/customAppBar.dart';

class MyDesigners extends StatefulWidget {
  @override
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
    var _controller = TextEditingController();
    var _visibleRemove = Colors.transparent;
    return Scaffold(
      appBar: CustomAppBar(showArrow: true, title: "Designers",),
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
                            color: Color.fromRGBO(150, 150, 150, 1), width: 2.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.transparent ),
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
