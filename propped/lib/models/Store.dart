class Store {
  final int id;
  final String code;
  final String name;
  final String city;
  final String country;
  final String phone;
  final String state;
  final String website;

  Store({this.id, this.code, this.name, this.city, this.country, this.phone, this.state, this.website});

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
        id: json['id_store'],
        code: json['code_store'],
        name: json['name_store'],
        city: json['city_store'],
        country: json['country_store'],
        phone: json['phone_store'],
        state: json['state_store'],
      website: json['website_store']
    );
  }
}
