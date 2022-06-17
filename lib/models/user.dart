class User {
  int id;
  String username;
  String email;
  // String provider;
  // bool confirmed;
  // bool blocked;
  // Role? role;

  User({required this.id, required this.username, this.email = ''});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'], username: json['username'], email: json['email']);
  }
}
