import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:propped/models/Favorite.dart';
import 'package:propped/screens/searchCategoryResult.dart';
import 'package:propped/models/Category.dart';
import 'package:propped/models/Subcategory.dart';
import 'package:propped/widgets/customAppBar.dart';
import 'package:propped/widgets/filterItem.dart';
import 'package:propped/widgets/menu.dart';
import 'package:propped/widgets/productGridItem.dart';

class MySearchResult extends StatefulWidget {
  MySearchResult({Key key, @required String keyword})
      : this.keyword = keyword,
        super(key: key);

  final String keyword;

  @override
  _SearchResult createState() => _SearchResult();
}

class _SearchResult extends State<MySearchResult> {
  Category cat;
  Subcategory subCat;
  Sorting _character = Sorting.Recommended;
  List filterItems = ["Color", "Sizes", "Price Range", "Occasion"];

  void _showRefineModal() {
    showCupertinoModalBottomSheet(
        expand: false,
        context: context,
        builder: (context, ScrollController sc) => Material(
          child: Navigator(
            onGenerateRoute: (_) => MaterialPageRoute(
              builder: (context) => Builder(
                builder: (context) => CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                      leading: Container(), middle: Text('Refine')),
                  child: SafeArea(
                      bottom: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 300.0,
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 10),
                                  child: Text("Order by",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'Ubuntu',
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(
                                              40, 40, 40, 1))),
                                ),
                                Container(
                                  decoration: new BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1.0,
                                              style: BorderStyle.solid,
                                              color: Colors.black26))),
                                  child: ListTile(
                                      title: const Text('Recommended'),
                                      leading: Transform.scale(
                                        scale: 1.4,
                                        child: Radio(
                                          activeColor:
                                          Color.fromRGBO(30, 30, 30, 1),
                                          value: Sorting.Recommended,
                                          groupValue: _character,
                                          onChanged: (Sorting value) {
                                            setState(() {
                                              _character = value;
                                            });
                                          },
                                        ),
                                      )),
                                ),
                                Container(
                                  decoration: new BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1.0,
                                              style: BorderStyle.solid,
                                              color: Colors.black26))),
                                  child: ListTile(
                                      title: const Text('Most Recent'),
                                      leading: Transform.scale(
                                        scale: 1.4,
                                        child: Radio(
                                          activeColor:
                                          Color.fromRGBO(30, 30, 30, 1),
                                          value: Sorting.Recent,
                                          groupValue: _character,
                                          onChanged: (Sorting value) {
                                            setState(() {
                                              _character = value;
                                            });
                                          },
                                        ),
                                      )),
                                ),
                                Container(
                                  decoration: new BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1.0,
                                              style: BorderStyle.solid,
                                              color: Colors.black26))),
                                  child: ListTile(
                                      title:
                                      const Text('Price (low to high)'),
                                      leading: Transform.scale(
                                        scale: 1.4,
                                        child: Radio(
                                          activeColor:
                                          Color.fromRGBO(30, 30, 30, 1),
                                          value: Sorting.Price,
                                          groupValue: _character,
                                          onChanged: (Sorting value) {
                                            setState(() {
                                              _character = value;
                                            });
                                          },
                                        ),
                                      )),
                                ),
                                Container(
                                  decoration: new BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1.0,
                                              style: BorderStyle.solid,
                                              color: Colors.black26))),
                                  child: ListTile(
                                      title:
                                      const Text('Price (high to low)'),
                                      leading: Transform.scale(
                                        scale: 1.4,
                                        child: Radio(
                                          activeColor:
                                          Color.fromRGBO(30, 30, 30, 1),
                                          value: Sorting.Prices,
                                          groupValue: _character,
                                          onChanged: (Sorting value) {
                                            setState(() {
                                              _character = value;
                                            });
                                          },
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Text("Filter by",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(40, 40, 40, 1))),
                          ),
                          Expanded(
                            child: ListView(
                              physics: new BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              shrinkWrap: true,
                              children: ListTile.divideTiles(
                                context: context,
                                tiles: List.generate(
                                    filterItems.length,
                                        (index) => GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FilterItem(
                                                      filterName:
                                                      filterItems[
                                                      index],
                                                    )));
                                      },
                                      child: Container(
                                        height: 60,
                                        decoration: new BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 1.0,
                                                    style: BorderStyle
                                                        .solid,
                                                    color: Colors
                                                        .black26))),
                                        child: Padding(
                                          padding: const EdgeInsets
                                              .symmetric(
                                              horizontal: 20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                filterItems[index]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 17),
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: Color.fromRGBO(
                                                    30, 30, 30, 1),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                              ).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                15.0, 20.0, 15.0, 20.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: RaisedButton(
                                  onPressed: () {
                                    debugPrint("results to be shown");
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(6)),
                                  color: Color.fromARGB(255, 30, 30, 30),
                                  child: Text('SHOW RESULTS',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Ubuntu',
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(
                                              240, 240, 240, 1)))),
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*Here i'm not worrying about menu or notification bar height,
    because the grid parent has vertical scroll behaviour.*/
    final double itemHeight = size.height / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        showArrow: true,
        title: widget.keyword,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(7.5, 50, 7.5, 0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 7.5, right: 7.5, top: 40, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "1201 items found",
                    style: TextStyle(
                        color: Color.fromRGBO(30, 30, 30, 1), fontSize: 16),
                  ),
                  OutlinedButton(
                    onPressed: () => {
                      _showRefineModal()
                    },
                    child: Row(
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(
                          Icons.reorder_rounded,
                          color: Color.fromRGBO(30, 30, 30, 1),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                          child: Text(
                            "Refine",
                            style: TextStyle(
                                color: Color.fromRGBO(30, 30, 30, 1),
                                fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.only(top: 0),
                physics: new BouncingScrollPhysics(),
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeight),
                // Generate 100 widgets that display their index in the List.
                children: List.generate(10, (index) {
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 15),
                      child: ProductGridItem(
                        text1: "Martine Rose",
                        text2: "Colorblock Pants",
                        text3: "1350.0",
                        image: "https://www.rebeccataylor.com/dw/image/v2/ABBY_PRD/on/demandware.static/-/Sites-master-catalog-rebeccataylor/default/dw78a1f271/hi-res/large/220600p416_multi_combo_front.jpg?sw=1218&sh=1848&sm=fit",
                        isFavorite: false,
                        favorite: new Favorite(id: 10, product: 95, user: 14, code: "aakakakkak"),
                        redirectCode: "A",
                      )
                  );
                }),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: MyMenu(
        meIcon: CupertinoIcons.person,
        searchIcon: Icons.search,
        homeIcon: CupertinoIcons.home,
        wishlistIcon: CupertinoIcons.heart,
      ),
    );
  }
}
