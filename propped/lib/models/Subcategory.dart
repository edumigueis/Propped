class Subcategory {
  int id;
  String code;
  String name;

  Subcategory(int id, String code, String name){
    this.id = id;
    this.code = code;
    this.name = name;
  }

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(json['id_subcategory'],json['code_subcategory'].toString(), json['name_subcategory'].toString());
  }
}