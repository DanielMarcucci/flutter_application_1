import 'package:flutter_application_1/models/user.dart';

class AuthData {
  final String jwt;
  final User user;

  AuthData({required this.jwt, required this.user});

  factory AuthData.fromJson(Map<String, dynamic> json) {
    User user = User.fromJson(json["user"]);
    return AuthData(user: user, jwt: json["jwt"]);
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data["jwt"] = jwt;
  //   data["user"] = user;
  //   return data;
  // }
}
