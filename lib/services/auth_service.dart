import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_application_1/api/constants.dart';
import 'package:flutter_application_1/models/auth_data.dart';
import 'package:flutter_application_1/models/user.dart';

class AuthService {
  // final String baseUrl = 'http://192.168.0.6:1337';

  static final SESSION = FlutterSession();

  Future<dynamic> register(String email, String password) async {
    try {
      var url = Uri.parse('$apiDomain/auth/register');
      var res = await http.post(url, body: {
        'email': email,
        'password': password,
      });

      return res.body;
    } finally {
      // done you can do something here
    }
  }

  Future<dynamic> login(String identifier, String password) async {
    try {
      var url = Uri.parse('$apiDomain/auth/local');
      var res = await http.post(
        url,
        body: {
          'identifier': identifier,
          'password': password,
          // 'token': 'SdxIpaQp!81XS#QP5%w^cTCIV*DYr',
        },
      );
      debugPrint(res.body);
      return res.body;
    } finally {
      // you can do somethig here
    }
  }

  Future<AuthData> loginTest(String identifier, String password) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: {
        'identifier': identifier,
        'password': password,
      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return AuthData.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  static setAuthData(String jwt, User user) async {
    await SESSION.set("token", jwt);
    await SESSION.set("userId", user.id);
    await SESSION.set("username", user.username);
  }

  // static setToken(String token, String refreshToken) async {
  //   _AuthData data = _AuthData(token, refreshToken, "");
  //   await SESSION.set('tokens', data);
  // }

  // static Future<Map<String, dynamic>> getToken() async {
  static Future<String> getToken() async => await SESSION.get('token');

  static Future<int> getUserId() async => await SESSION.get('userId');

  static Future<String> getUsername() async => await SESSION.get('username');

  static removeToken() async {
    await SESSION.prefs.clear();
  }
}

// class _AuthData {
//   String jwt;
//   _AuthDat({this.jwt});

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();

//     data['jwt'] = jwt;
//     // data['refreshToken'] = refreshToken;
//     // data['clientId'] = clientId;
//     return data;
//   }
// }

// class _AuthData {
//   String token, refreshToken, clientId;
//   _AuthData(this.token, this.refreshToken, this.clientId);

//   // toJson
//   // required by Session lib
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();

//     data['token'] = token;
//     data['refreshToken'] = refreshToken;
//     data['clientId'] = clientId;
//     return data;
//   }
// }
