import 'package:propped/utils/PriceRange.dart';

class FiltersCollection {
  String color;
  PriceRange range;

  FiltersCollection() {}

  String getColor() {
    return this.color;
  }

  PriceRange getPriceRange(){
    return this.range;
  }

  void setColor(String color) {
    this.color = color;
  }

  void setPriceRange(PriceRange range){
    this.range = range;
  }
}
