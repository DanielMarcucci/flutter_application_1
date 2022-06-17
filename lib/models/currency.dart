import 'package:flutter_application_1/models/card.dart';

class Currency {
  int id;
  String name;
  String symbol;
  String isoCode;

  Currency(
      {required this.id,
      this.name = '',
      required this.symbol,
      this.isoCode = ''});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
        id: json['id'],
        name: json['name'],
        symbol: json['symbol'],
        isoCode: json['iso_code']);
  }
}
