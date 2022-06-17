import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/api/constants.dart';
import 'package:flutter_application_1/services/auth_service.dart';

class CustomerService {
  static Future<dynamic> find() async {
    try {
      String token = await AuthService.getToken();
      int id = await AuthService.getUserId();
      var url = Uri.parse('$apiDomain/customers?users_id.id=$id');
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
}
