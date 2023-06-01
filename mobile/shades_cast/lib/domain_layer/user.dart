class User {
  int id;
  String name;
  String email;
  String? password;
  Map<String, dynamic>? profile;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      this.profile});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "password": password,
      'profile': profile,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'],
        name: map['username'],
        email: map['email'],
        password: map['password'],
        profile: map['profile']);
  }
}
