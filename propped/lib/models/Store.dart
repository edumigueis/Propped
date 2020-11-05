class Store {
  final int id;
  final int code;
  final String name;

  Store({this.id, this.code, this.name});

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
        code: json['code_store'],
        name: json['name_store']
    );
  }
}
