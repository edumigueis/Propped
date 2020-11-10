class Product {
  final int id;
  final String code;
  final int store;
  final String name;
  final String description;
  final double weight;
  final int price;
  final int stock;
  final List<String> images;

  Product(
      {this.id,
      this.code,
      this.store,
      this.name,
      this.description,
      this.weight,
      this.price,
      this.stock, this.images});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id_product'],
        code: json['code_product'],
        store: json['id_store_product'],
        name: json['name_product'],
        description: json['description_product'],
        weight: json['weight_product'],
        price: json['price_product'],
        stock: json['stock_product']);
  }
}
