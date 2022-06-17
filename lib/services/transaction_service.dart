import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/api/constants.dart';
import 'package:flutter_application_1/services/auth_service.dart';

class TransactionService {
  static Future<dynamic> save(Map<String, String> body) async {
    try {
      String token = await AuthService.getToken();
      var url = Uri.parse('$apiDomain/transactions');
      var res = await http.post(url,
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

  static Future<dynamic> findByCustomerId(int id) async {
    try {
      String token = await AuthService.getToken();
      var url = Uri.parse(
          '$apiDomain/transactions?account_id.customer_id=$id&_limit=6');
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
