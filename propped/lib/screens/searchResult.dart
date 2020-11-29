import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:propped/models/Favorite.dart';
import 'package:propped/models/Image.dart';
import 'package:propped/models/Store.dart';
import 'package:propped/screens/searchCategoryResult.dart';
import 'package:propped/models/Category.dart';
import 'package:propped/models/Subcategory.dart';
import 'package:propped/models/Product.dart';
import 'package:propped/utils/Constants.dart';
import 'package:propped/utils/FiltersCollection.dart';
import 'package:propped/widgets/customAppBar.dart';
import 'package:propped/widgets/errorMsgWidget.dart';
import 'package:propped/widgets/filterItem.dart';
import 'package:propped/widgets/menu.dart';
import 'package:propped/widgets/productGridItem.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

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
  Sorting _sorting = Sorting.Recommended;
  List filterItems = ["Color", "Sizes", "Price Range", "Occasion"];
  FiltersCollection filters = new FiltersCollection();

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
                                child: StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                activeColor: Color.fromRGBO(
                                                    30, 30, 30, 1),
                                                value: Sorting.Recommended,
                                                groupValue: _sorting,
                                                onChanged: (Sorting value) {
                                                  setState(() {
                                                    _sorting = value;
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
                                                activeColor: Color.fromRGBO(
                                                    30, 30, 30, 1),
                                                value: Sorting.Recent,
                                                groupValue: _sorting,
                                                onChanged: (Sorting value) {
                                                  setState(() {
                                                    _sorting = value;
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
                                            title: const Text(
                                                'Price (low to high)'),
                                            leading: Transform.scale(
                                              scale: 1.4,
                                              child: Radio(
                                                activeColor: Color.fromRGBO(
                                                    30, 30, 30, 1),
                                                value: Sorting.Price,
                                                groupValue: _sorting,
                                                onChanged: (Sorting value) {
                                                  setState(() {
                                                    _sorting = value;
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
                                            title: const Text(
                                                'Price (high to low)'),
                                            leading: Transform.scale(
                                              scale: 1.4,
                                              child: Radio(
                                                activeColor: Color.fromRGBO(
                                                    30, 30, 30, 1),
                                                value: Sorting.Prices,
                                                groupValue: _sorting,
                                                onChanged: (Sorting value) {
                                                  setState(() {
                                                    _sorting = value;
                                                  });
                                                },
                                              ),
                                            )),
                                      ),
                                    ],
                                  );
                                }),
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
                                                                callback:
                                                                    (val) => {
                                                                          retrieveNonNulls(
                                                                              val)
                                                                        })));
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
                                        if (filters.getPriceRange() != null) {
                                          fetchResults(
                                              -1,
                                              -1,
                                              this.filters.getColor(),
                                              this
                                                      .filters
                                                      .getPriceRange()
                                                      .getStart()
                                                      .toString() +
                                                  " " +
                                                  this
                                                      .filters
                                                      .getPriceRange()
                                                      .getEnd()
                                                      .toString(),
                                              this.filters.getOccasion(),
                                              this.filters.getSize());
                                        } else {
                                          fetchResults(
                                              -1,
                                              -1,
                                              this.filters.getColor(),
                                              "0 1000000",
                                              this.filters.getOccasion(),
                                              this.filters.getSize());
                                        }
                                        sortResults();
                                        //Navigator.pop(context);
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

  void retrieveNonNulls(FiltersCollection value) {
    if (value.size != null) this.filters.size = value.getSize();
    if (value.color != null) this.filters.color = value.getColor();
    if (value.occasion != null) this.filters.occasion = value.getOccasion();
    if (value.getPriceRange() != null)
      this.filters.setPriceRange(value.getPriceRange());

    debugPrint("-------------------------");
    debugPrint(filters.getColor().toString());
    debugPrint(filters.getPriceRange().toString());
    debugPrint(filters.getSize().toString());
    debugPrint(filters.getOccasion().toString());
  }

  void sortResults() {
    if (this._sorting == Sorting.Recommended)
      return;
    else if (this._sorting == Sorting.Recent)
      debugPrint("Recent");
    else if (this._sorting == Sorting.Price)
      debugPrint("Price(low to high)");
    else if (this._sorting == Sorting.Prices) debugPrint("Price(high to low)");
  }

  Future<List<Product>> fetchResults(int cat, int subCat, String color,
      String range, String occ, String size) async {
    if (occ == null) occ = "";
    if (size == null) size = "";
    if (color == null) color = "";

    final http.Response response = await http.post(
      'http://' + Constants.serverIP + '/products/search',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "name_product": this.widget.keyword,
        "id_category_product": cat,
        "id_subcategory_product": subCat,
        "filters_product": [color, range, occ, size]
      }),
    );
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      debugPrint(response.body.toString());
      List<dynamic> values = new List<dynamic>();
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            this.products.add(Product.fromJson(map));
          }
        }
      }
      await fetchStores(products);
      return this.products;
    } else if (response.statusCode == 404) {
      setState(() {
        this.nothingFound = true;
        this.msg = "We couldn't find what you are searching for.";
        this.titleMsg = "No Results";
      });
    } else {
      setState(() {
        this.nothingFound = true;
        this.msg =
            "There has been a problem with the search. Please try again and check your internet connection.";
        this.titleMsg = "Oops...";
      });
    }
  }

  Future<List<Store>> fetchStores(List<Product> prod) async {
    for (int f = 0; f < prod.length; f++) {
      final response = await http.get('http://' +
          Constants.serverIP +
          '/stores/' +
          prod[f].store.toString());

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        List<dynamic> values = new List<dynamic>();
        values = json.decode(response.body);
        if (values.length > 0) {
          if (values[0] != null) {
            Map<String, dynamic> map = values[0];
            stores.add(Store.fromJson(map));
          }
        }
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load products');
      }
    }
    await fetchImages(this.products);
    if (this.mounted) setState(() {});
    return stores;
  }

  Future<List<ImageObj>> fetchImages(List<Product> prod) async {
    for (int f = 0; f < prod.length; f++) {
      final response = await http.get('http://' +
          Constants.serverIP +
          '/products/image/' +
          prod[f].id.toString());

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        List<dynamic> values = new List<dynamic>();
        values = json.decode(response.body);
        if (values.length > 0) {
          if (values[0] != null) {
            Map<String, dynamic> map = values[0];
            images.add(ImageObj.fromJson(map));
          }
        }
      } else {
        // If that call was not successful, throw an error.
        this.images.add(new ImageObj(url: "", idImage: -1, idProduct: -1));
      }
      await fetchImagesProp();
    }

    return images;
  }

  Future<List<ImageObj>> fetchImagesProp() async {
    for (int f = 0; f < images.length; f++) {
      final response = await http.get('http://' +
          Constants.serverIP +
          '/images/id/' +
          images[f].idImage.toString());

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        List<dynamic> values = new List<dynamic>();
        values = json.decode(response.body);

        if (values.length > 0) {
          if (values[0] != null) {
            Map<String, dynamic> map = values[0];
            this.images[f].url = map['photo_image'];
          }
        }
      } else {
        // If that call was not successful, throw an error.
        this.images[f].url =
            "https://icons-for-free.com/iconfiles/png/512/facebook+sad+emoji+sad+face+icon-1320166641720234915.png";
      }
    }
    return images;
  }

  List<Product> products = new List<Product>();
  List<Store> stores = new List<Store>();
  List<ImageObj> images = new List<ImageObj>();
  int idUser = 25;
  bool nothingFound = false;
  String msg = "";
  String titleMsg = "";

  @override
  void initState() {
    super.initState();
    this.fetchResults(-1, -1, "", "-1", "", "");
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
                    () {
                      int length = this.products.length;
                      if (length == 1)
                        return "1 item found";
                      else
                        return length.toString() + " item found";
                    }(),
                    style: TextStyle(
                        color: Color.fromRGBO(30, 30, 30, 1), fontSize: 16),
                  ),
                  OutlinedButton(
                    onPressed: () => {_showRefineModal()},
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
            Expanded(child: () {
              if (!this.nothingFound)
                return GridView.count(
                  padding: const EdgeInsets.only(top: 20),
                  physics: new BouncingScrollPhysics(),
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: 2,
                  childAspectRatio: (itemWidth / itemHeight),
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(products.length, (index) {
                    String img;
                    if (images == null || images.length == 0)
                      img = "a";
                    else if (images[index] == null)
                      img = "a";
                    else
                      img = images[index].url;
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 15),
                      child: ProductGridItem(
                        redirectCode: products[index].code,
                        image: img,
                        text1: stores[index].name,
                        text2: products[index].name,
                        text3: products[index].price.toString(),
                        isFavorite: false,
                        favorite: new Favorite(
                            product: this.products[index].id,
                            user: this.idUser),
                      ),
                    );
                  }),
                );
              else {
                return ErrorMsgWidget(title: this.titleMsg, message: this.msg);
              }
            }())
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
