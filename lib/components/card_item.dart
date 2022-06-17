import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/card_component.dart';
import 'package:flutter_application_1/screens/transaction_screen.dart';
import 'package:flutter_application_1/models/account.dart';

class CardItemComponent extends StatelessWidget {
  const CardItemComponent(
      {Key? key, required this.account, required this.onRefresh})
      : super(key: key);

  final Account account;
  final Future Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          final value = await Navigator.push(
              context,
              PageRouteBuilder(
                  pageBuilder: (context, a, b) =>
                      TransactionScreen(account: account)));
          onRefresh();
        },
        child: CardComponent(account: account));
  }
}
