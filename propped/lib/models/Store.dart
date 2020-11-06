class Store {
  final int id;
  final String code;
  final String name;

  Store({this.id, this.code, this.name});

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
        id: json['id_store'],
        code: json['code_store'],
        name: json['name_store']
    );
  }
}
