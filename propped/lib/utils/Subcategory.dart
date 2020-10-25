class Subcategory {
  int id;
  String code;
  String name;

  Subcategory(int id, String code, String name){
    this.id = id;
    this.code = code;
    this.name = name;
  }

  int getId(){
    return this.id;
  }

  String getCode(){
    return this.code;
  }

  String getName(){
    return this.name;
  }
}