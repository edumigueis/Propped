import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 15),
          child: Text("Contact Us",
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(40, 40, 40, 1))),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Colors.black26),
                  bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Colors.black26))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.phone,
                      color: Color.fromRGBO(30, 30, 30, 1),
                      size: 35,
                    ),
                    Text(
                      "Call Us",
                      style: TextStyle(
                          height: 2,
                          color: Color.fromRGBO(30, 30, 30, 1),
                          fontSize: 18),
                    )
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.email,
                      color: Color.fromRGBO(30, 30, 30, 1),
                      size: 35,
                    ),
                    Text(
                      "Email Us",
                      style: TextStyle(
                          height: 2,
                          color: Color.fromRGBO(30, 30, 30, 1),
                          fontSize: 18),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Center(
            child: Image.asset(
              'assets/images/Propped-Red.png',
              width: 150,
            ),
          ),
        )
      ],
    );
  }
}
