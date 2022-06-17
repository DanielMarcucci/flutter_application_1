import 'package:flutter_application_1/models/card.dart';
import 'package:flutter_application_1/models/currency.dart';

class Account {
  int id;
  String accountNumber;
  num currentBalance;
  String alias;
  Card? card;
  Currency? currency;

  Account(
      {required this.id,
      required this.accountNumber,
      this.currentBalance = 0,
      this.alias = '',
      this.card,
      this.currency});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
        id: json['id'],
        accountNumber: json['account_number'],
        currentBalance: json['current_balance'] ?? 0,
        alias: json['alias'],
        currency: Currency.fromJson(json['currency_id']),
        card: json['card_id'] == null ? null : Card.fromJson(json['card_id']));
  }
}
