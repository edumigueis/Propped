class Designers{
  String code;
  String name;

  Designers(String code, String name){
    this.code = code;
    this.name = name;
  }

  String getName(){
    return this.name;
  }

  String getCode(){
    return this.code;
  }

  factory Designers.fromJson(Map<String, dynamic> json) {
    return Designers(json['code_store'].toString(), json['name_store'].toString());
  }

}