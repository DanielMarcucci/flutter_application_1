import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/api/constants.dart';
import 'package:flutter_application_1/services/auth_service.dart';

class AccountService {
  static Future<dynamic> find(int id) async {
    try {
      String token = await AuthService.getToken();
      var url = Uri.parse('$apiDomain/accounts?customer_id.id=$id');
      var res = await http.get(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      debugPrint(res.body);
      return res.body;
    } finally {
      // you can do somethig here
    }
  }

  static Future<dynamic> findNotEqual(int id) async {
    try {
      String token = await AuthService.getToken();
      var url = Uri.parse('$apiDomain/accounts?id_ne=$id');
      var res = await http.get(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      debugPrint(res.body);
      return res.body;
    } finally {
      // you can do somethig here
    }
  }

  static Future<dynamic> update(int id, Map<String, String> body) async {
    try {
      String token = await AuthService.getToken();
      var url = Uri.parse('$apiDomain/accounts/$id');
      var res = await http.put(url,
          headers: <String, String>{
            'Authorization': 'Bearer $token',
            // 'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
      debugPrint(res.body);
      return res.body;
    } finally {
      // you can do somethig here
    }
  }
}
