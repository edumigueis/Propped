import 'package:propped/utils/PriceRange.dart';

class FiltersCollection {
  String color;
  PriceRange range;
  String size;

  FiltersCollection() {}

  String getColor() {
    return this.color;
  }

  PriceRange getPriceRange(){
    return this.range;
  }

  String getSize(){
    return this.size;
  }

  void setColor(String color) {
    this.color = color;
  }

  void setPriceRange(PriceRange range){
    this.range = range;
  }

  void setSize(String size){
    this.size = size;
  }
}
