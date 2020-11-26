import 'package:propped/models/Product.dart';
import 'package:propped/models/Store.dart';

class BagItem{
  final Product product;
  Store store;
  final int quantity;
  final String size;
  String country;

  BagItem({this.product, this.store, this.quantity, this.size, this.country});
}