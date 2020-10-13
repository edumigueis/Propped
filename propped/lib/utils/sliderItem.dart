class SliderItem{
  double price;
  String name, cat;

  SliderItem(String name, String cat, double price){
    this.price = price;
    this.name = name;
    this.cat = cat;
  }

  double getPrice(){
    return this.price;
  }

  String getName(){
    return this.name;
  }

  String getCategory(){
    return this.cat;
  }
}