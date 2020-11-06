class User {
  final int id;
  final String code;
  final String name;
  final String email;
  final String preference;
  final String password;

  User({this.id, this.code, this.name, this.email, this.password, this.preference});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id_user'],
      code: json['code_user'],
      name: json['name_user'],
      email: json['email_user'],
      password: json['pass_user'],
      preference: json['preference_user']
    );
  }
}
