class SliderItem{
  double price;
  String name, cat, image;

  SliderItem(String name, String cat, double price, String image){
    this.price = price;
    this.name = name;
    this.cat = cat;
    this.image = image;
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

  String getImage(){
    return this.image;
  }
}