import 'package:flutter_application_1/components/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({Key? key, required this.transactionsData})
      : super(key: key);

  final List<dynamic> transactionsData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        // itemCount: this.jobs.length,
        itemCount: transactionsData.length,
        // itemBuilder: (context, index) => CompactItemJob(this.jobs[index]),
        itemBuilder: (context, index) {
          final Map<String, dynamic> transactionData =
              transactionsData[index] as Map<String, dynamic>;
          final Transaction transaction = Transaction.fromJson(transactionData);
          return TransactionItem(transaction: transaction);
        });
  }
}
