class Category{
  String code, name;
  int id;

  Category(int id, String code, String name){
    this.id = id;
    this.code = code;
    this.name = name;
  }

  String getName(){
    return this.name;
  }

  int getId(){
    return this.id;
  }

  String getCode(){
    return this.code;
  }
}
