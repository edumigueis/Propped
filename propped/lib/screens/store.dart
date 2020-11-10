import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:propped/models/Product.dart';
import 'package:propped/models/Store.dart';
import 'package:propped/screens/home.dart';
import 'package:propped/utils/Constants.dart';
import 'package:propped/widgets/customAppBar.dart';
import 'package:propped/widgets/menu.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MyStore extends StatefulWidget {
  MyStore({Key key, @required int id})
      : this.id = id,
        super(key: key);

  final int id;

  @override
  _MyStoreState createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore> {
  Store store = new Store(name: "", country: "", city: "");

  @override
  void initState() {
    super.initState();
    fetchStore(widget.id);
  }

  void _showModal() {
    showCupertinoModalBottomSheet(
        expand: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context, ScrollController sc) => Material(
                child: SafeArea(
              top: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("About",
                        style: TextStyle(
                            fontSize: 17,
                            height: 2,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(30, 30, 30, 1))),
                    ListTile(
                      title: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras fermentum eros et nisi iaculis ornare. Ut condimentum sollicitudin felis a mattis. Praesent dignissim tellus ligula, non egestas odio fermentum non. Phasellus volutpat purus at leo tristique, nec lobortis erat viverra."),
                      contentPadding: EdgeInsets.symmetric(vertical: 7),
                    ),
                    Text("Phone",
                        style: TextStyle(
                            fontSize: 17,
                            height: 2,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(30, 30, 30, 1))),
                    ListTile(
                      title: Text(this.store.phone),
                      contentPadding: EdgeInsets.symmetric(vertical: 7),
                    ),
                    Text("Website",
                        style: TextStyle(
                            fontSize: 17,
                            height: 2,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(30, 30, 30, 1))),
                    ListTile(
                      title: Text(this.store.website),
                      contentPadding: EdgeInsets.symmetric(vertical: 7),
                    ),
                    Text("Location",
                        style: TextStyle(
                            fontSize: 17,
                            height: 2,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(30, 30, 30, 1))),
                    ListTile(
                      title: Text((){
                        return this.store.city + ", " + this.store.state + ", " + this.store.country;
                      }()),
                      contentPadding: EdgeInsets.symmetric(vertical: 7),
                    ),
                  ],
                ),
              ),
            )));
  }

  Future<Store> fetchStore(int code) async {
    debugPrint('http://' + Constants.serverIP + '/stores/' + code.toString());
    final response = await http
        .get('http://' + Constants.serverIP + '/stores/' + code.toString());

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values = new List<dynamic>();
      values = json.decode(response.body);
      if (values.length > 0) {
        if (values[0] != null) {
          Map<String, dynamic> map = values[0];
          this.store = Store.fromJson(map);
        }
      }
      await fetchProductsByDesigners();
      if (this.mounted) setState(() {});
      return store;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load user');
    }
  }

  Future<List<Product>> fetchProductsByDesigners() async {
    final response = await http.get('http://' + Constants.serverIP + '/products');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values = new List<dynamic>();
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            productsDesigner.add(Product.fromJson(map));
          }
        }
      }
      if (this.mounted) setState(() {});
      return productsDesigner;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load products from this store');
    }
  }

  List<Product> productsDesigner = new List<Product>();

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
      appBar: CustomAppBar(showArrow: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: ListView(
            physics: new BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: 90),
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 125,
                  width: 125,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://images.pexels.com/photos/2101839/pexels-photo-2101839.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"))),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20, bottom: 15),
                child: Text(this.store.name,
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(30, 30, 30, 1))),
              ),
              Center(
                child: Text(
                    this.store.city.toUpperCase() +
                        ", " +
                        this.store.country.toUpperCase(),
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w900,
                        color: Color.fromRGBO(30, 30, 30, 1))),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                        onPressed: () {
                          _showModal();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        color: Color.fromARGB(255, 30, 30, 30),
                        child: Text('SEE MORE',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(240, 240, 240, 1))))),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyHome()),
                          );
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: BorderSide(
                                color: Color.fromRGBO(30, 30, 30, 1),
                                width: 2.5)),
                        color: Colors.white,
                        child: Text('RATINGS',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(30, 30, 30, 1))))),
              ),
              GridView.count(
                padding: const EdgeInsets.only(top: 20),
                physics: new BouncingScrollPhysics(),
                shrinkWrap: true,
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeight),
                // Generate 100 widgets that display their index in the List.
                children: List.generate(productsDesigner.length, (index) {
                  return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width / 2,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Image(
                                    image: NetworkImage(
                                        'https://cdn-images.farfetch-contents.com/15/23/22/29/15232229_29297818_1000.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: new Icon(Icons.star, size: 30),
                                )
                              ],
                            )),
                        Text('Martine Rose',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(120, 120, 120, 1)),
                            textAlign: TextAlign.center),
                        Text(this.productsDesigner[index].name,
                            style: TextStyle(
                                fontSize: 19.0,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(40, 40, 40, 1)),
                            textAlign: TextAlign.center),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Text('USD \$'+ this.productsDesigner[index].price.toString(),
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(40, 40, 40, 1)),
                              textAlign: TextAlign.center),
                        )
                      ]);
                }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyMenu(
        meIcon: CupertinoIcons.person,
        searchIcon: CupertinoIcons.search,
        homeIcon: Icons.home,
        wishlistIcon: Icons.star_border,
      ),
    );
  }
}
