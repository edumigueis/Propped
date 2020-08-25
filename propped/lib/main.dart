import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

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
                  child: Image.asset('assets/images/main.jpg',
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
          style: TextStyle(fontSize: 25.0, fontFamily: 'Ubuntu', fontWeight: FontWeight.bold),
        ),
      ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 20.0),
              child: Text(
                "The biggest and most inclusive clothing e-commerce. Enjoy the amazing propped app, with everything you need.",
                style: TextStyle(fontSize: 18.0, fontFamily: 'Ubuntu', fontWeight: FontWeight.bold, color: Color.fromRGBO(40, 40, 40, 1)),
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
                      child: FlatButton(onPressed:  () {},
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(side: BorderSide(
                              color: Color.fromARGB(255, 30, 30, 30),
                              width: 3,
                              style: BorderStyle.solid
                          ), borderRadius: BorderRadius.circular(5)),
                          child: Text('LOGIN', style: TextStyle(fontSize: 17, fontFamily: 'Ubuntu', fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 10)))
                      ),
                    )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 10.0),
                    child: SizedBox(
                      width: 150,
                      height: 50,
                      child: RaisedButton(onPressed:  () {},
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          color: Color.fromARGB(255, 30, 30, 30),
                          child: Text('REGISTER', style: TextStyle(fontSize: 17, fontFamily: 'Ubuntu',fontWeight: FontWeight.bold, color: Color.fromRGBO(240, 240, 240, 1)))
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
