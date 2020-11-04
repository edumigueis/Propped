class Product {
  final int id;
  final String code;
  final String name;
  final String description;
  final double weight;
  final double price;
  final int stock;

  Product(
      {this.id,
      this.code,
      this.name,
      this.description,
      this.weight,
      this.price,
      this.stock});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id_product'],
        code: json['code_product'],
        name: json['name_product'],
        description: json['description_product'],
        weight: json['weight_product'],
        price: json['price_product'],
        stock: json['stock_product']);
  }
}
