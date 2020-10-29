import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:propped/utils/PriceRange.dart';

typedef void ValueRetriever(PriceRange val);

class PriceRangeFilter extends StatefulWidget {
  PriceRangeFilter({Key ky, this.callback});

  final ValueRetriever callback;

  @override
  PriceRangeFilterState createState() => PriceRangeFilterState(callback);
}

class PriceRangeFilterState extends State<PriceRangeFilter> {
  final ValueRetriever cb;

  PriceRangeFilterState(this.cb);

  PriceRange range = new PriceRange(20, 100000);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(CupertinoIcons.money_dollar),
          TextField(
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(30, 30, 30, 1),
                        width: 4.0),
                    borderRadius: BorderRadius.zero),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(30, 30, 30, 1),
                        width: 3.0),
                    borderRadius: BorderRadius.zero),
                hintText: 'Min'),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          Icon(Icons.money),
          TextField(
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(30, 30, 30, 1),
                        width: 4.0),
                    borderRadius: BorderRadius.zero),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(30, 30, 30, 1),
                        width: 3.0),
                    borderRadius: BorderRadius.zero),
                hintText: 'Max'),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ],
      ),
    );
  }
}
