import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propped/utils/FiltersCollection.dart';
import 'package:propped/widgets/colorFilter.dart';

class FilterItem extends StatelessWidget {
  FilterItem({Key key, @required String filterName})
      : this.filter = filterName,
        super(key: key);

  final String filter;
  FiltersCollection filterValues = new FiltersCollection();

  Widget _filterPage() {
    if (this.filter.trim() != "") {
      switch (this.filter.toUpperCase()) {
        case "COLOR":
          {
            return new ColorFilter(
              callback: (val) => {
                  filterValues.setColor(val)
              },
            );
          }
          break;
      }
    }
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
