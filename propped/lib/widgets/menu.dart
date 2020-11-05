import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/screens/home.dart';
import 'package:propped/screens/me.dart';
import 'package:propped/screens/product.dart';
import 'package:propped/screens/search.dart';
import 'package:propped/screens/wishlist.dart';

class MyMenu extends StatelessWidget {
  MyMenu({ Key key,
    @required this.meIcon,
    @required this.searchIcon,
    @required this.homeIcon,
    @required this.wishlistIcon,
  }) : super(key: key);

  BuildContext ctx;
  final IconData meIcon;
  final IconData searchIcon;
  final IconData homeIcon;
  final IconData wishlistIcon;
  /*void _loadCurrentIcon(BuildContext ctx) {
    switch (_currentIndex) {
      case 0:
        {
            _homeIcon = Icons.home;
        }
        break;
      case 1:
        {
            _searchIcon = CupertinoIcons.search;

        }
        break;
      case 2:
        {
            _wishlistIcon = Icons.star;

        }
        break;
      case 3:
        {
            _meIcon = CupertinoIcons.person_solid;
        }
        break;
    }
  }*/

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        {
          Navigator.push(
            ctx,
            MaterialPageRoute(builder: (context) => MyHome()),
          );
        }
        break;
      case 1:
        {
          Navigator.push(
            ctx,
            MaterialPageRoute(builder: (context) => MySearch()),
          );
        }
        break;
      case 2:
        {
          Navigator.push(
            ctx,
            MaterialPageRoute(builder: (context) => MyWishlist()),
          );
        }
        break;
      case 3:
        {
          Navigator.push(
            ctx,
            MaterialPageRoute(builder: (context) => MyProduct()),
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
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(homeIcon),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(searchIcon),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(wishlistIcon),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: Icon(meIcon),
          label: 'Me',
        )
      ],
      selectedItemColor: Colors.black,
      selectedIconTheme: IconThemeData(opacity: 1, size: 30),
      unselectedIconTheme: IconThemeData(opacity: 1, size: 28),
      onTap: _onItemTapped,
    );
  }
}
