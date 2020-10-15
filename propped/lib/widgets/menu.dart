

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/screens/home.dart';
import 'package:propped/screens/wishlist.dart';

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
      case 2:{
        Navigator.push(
          ctx,
          MaterialPageRoute(builder: (context) => MyWishlist()),
        );
      }
      break;
      case 3:{
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
      unselectedItemColor: Color.fromRGBO(35, 35, 35, 1),
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('Search'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star_border),
          title: Text('Wishlist'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Me'),
        )
      ],
      selectedItemColor: Colors.black,
      selectedIconTheme: IconThemeData(opacity: 1,size: 30),
      unselectedIconTheme: IconThemeData(opacity: 1,size: 28),
      onTap: _onItemTapped,
    );
  }
}
