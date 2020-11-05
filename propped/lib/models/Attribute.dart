class Attribute {
  final int id;
  final String value;
  final String name;

  Attribute({this.id, this.name, this.value});

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
        id: json['id_attribute'],
        name: json['name_attribute'],
        value: json['value_attribute']);
  }
}
