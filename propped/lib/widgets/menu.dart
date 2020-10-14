

import 'package:flutter/material.dart';
import 'package:propped/screens/home.dart';

class Menu extends StatelessWidget {
  BuildContext ctx;
  void _onItemTapped(int index) {
    switch (index) {
      case 0:{
        Navigator.push(
          ctx,
          MaterialPageRoute(builder: (context) => MyHome()),
        );
      }
      break;
      case 1:{
        Navigator.push(
          ctx,
          MaterialPageRoute(builder: (context) => MyHome()),
        );
      }
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('School'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('School'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          title: Text('School', ),
        ),
      ],
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
