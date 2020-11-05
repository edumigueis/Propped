class Favorite {
  final int id;
  final String code;
  final int user;
  final int product;

  Favorite({this.id, this.code, this.user, this.product});

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
        id: json['id_favorite'],
        code: json['code_favorite'],
        user: json['id_user_favorite'],
        product: json['id_product_favorite'],
    );
  }
}