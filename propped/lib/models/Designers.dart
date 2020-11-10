class Designers{
  int id;
  String code;
  String name;

  Designers(int id, String code, String name){
    this.id = id;
    this.code = code;
    this.name = name;
  }

  String getName(){
    return this.name;
  }

  String getCode(){
    return this.code;
  }

  int getId(){
    return this.id;
  }

  factory Designers.fromJson(Map<String, dynamic> json) {
    return Designers(json['id_store'], json['code_store'].toString(), json['name_store'].toString());
  }

}