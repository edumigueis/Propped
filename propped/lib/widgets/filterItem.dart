import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/utils/FiltersCollection.dart';
import 'package:propped/widgets/colorFilter.dart';
import 'package:propped/widgets/occasionFilter.dart';
import 'package:propped/widgets/priceRangeFilter.dart';
import 'package:propped/widgets/sizeFilter.dart';

typedef void ValueRetriever(FiltersCollection val);

class FilterItem extends StatelessWidget {
  FilterItem({Key key, @required String filterName, this.callback})
      : this.filter = filterName,
        super(key: key);

  final ValueRetriever callback;

  final String filter;
  FiltersCollection filterValues = new FiltersCollection();

  Widget _filterPage() {
    if (this.filter.trim() != "") {
      switch (this.filter.toUpperCase()) {
        case "COLOR":
          {
            return new ColorFilter(
              callback: (val) => {filterValues.setColor(val), callback(filterValues)},
    );
          }
          break;
        case "SIZES":
          {
            return new SizeFilter(callback: (val) => {filterValues.setSize(val), callback(filterValues)});
          }
          break;
        case "PRICE RANGE":
          {
            return new PriceRangeFilter(
              callback: (val) => {filterValues.setPriceRange(val), callback(filterValues)},
            );
          }
          break;
        case "OCCASION":
          {
            return new OccasionFilter(
              callback: (val) => { filterValues.setOccasion(val), callback(filterValues)},
            );
          }
          break;
      }
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        actionsForegroundColor: Color.fromRGBO(30, 30, 30, 1),
        middle: Text(this.filter),
      ),
      child: _filterPage(),
    );
  }
}
