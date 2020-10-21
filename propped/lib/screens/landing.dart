import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/screens/login.dart';
import 'package:propped/screens/register.dart';

class MyLanding extends StatefulWidget{
  MyLanding({Key key}) : super(key: key);

  @override
  _MyLandingState createState() => _MyLandingState();
}
class _MyLandingState extends State<MyLanding>{
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      /*appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),*/
      backgroundColor: Colors.white,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 10, // 20%
                  child: Image.asset(
                    'assets/images/main.jpg',
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.56,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 10.0),
              child: Text(
                "Welcome to Propped!",
                style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 20.0),
              child: Text(
                "The biggest and most inclusive clothing e-commerce. Enjoy the amazing propped app, with everything you need.",
                style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(40, 40, 40, 1)),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 10.0),
                    child: SizedBox(
                      width: 150,
                      height: 50,
                      child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyLogin()),
                            );
                          },
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Color.fromARGB(255, 30, 30, 30),
                                  width: 3,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text('LOGIN',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(0, 0, 0, 10)))),
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 10.0),
                    child: SizedBox(
                      width: 150,
                      height: 50,
                      child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyRegister()),
                            );
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          color: Color.fromARGB(255, 30, 30, 30),
                          child: Text('REGISTER',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(240, 240, 240, 1)))),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}