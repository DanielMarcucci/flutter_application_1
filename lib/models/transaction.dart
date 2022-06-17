import 'package:flutter_application_1/models/currency.dart';

class Transaction {
  int id;
  int accountId;
  num amount;
  String comments;
  DateTime date;
  Currency? currency;

  Transaction(
      {required this.id,
      required this.accountId,
      required this.amount,
      required this.comments,
      required this.date,
      this.currency});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      accountId: json['account_id']['id'],
      amount: json['amount'],
      comments: json['comments'],
      date: DateTime.parse(json['date']),
      currency: Currency.fromJson(json['currency_id']),
    );
  }
}
