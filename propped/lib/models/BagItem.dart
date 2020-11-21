import 'package:propped/models/Product.dart';

class BagItem{
  final Product product;
  final int quantity;
  final String size;

  BagItem({this.product, this.quantity, this.size});
}