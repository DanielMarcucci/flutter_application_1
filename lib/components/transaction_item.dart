import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({Key? key, required this.transaction})
      : super(key: key);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    String textCurrency =
        transaction.currency == null ? 'Q' : transaction.currency!.symbol;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
      child: Container(
        decoration: _boxDecoration(),
        height: 70.0,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                // _companyLogo(),
                _infoJobTexts(context),
              ],
            ),
            Text(
              NumberFormat.currency(symbol: textCurrency)
                  .format(transaction.amount),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Colors.black26,
          offset: Offset(2.0, 2.0),
          blurRadius: 8.0,
        ),
      ],
    );
  }

  // Widget _companyLogo() {
  //   return Padding(
  //     padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
  //     child: Image.network(
  //         "https://img.utdstc.com/icon/102/4be/1024be4462ba7a5daf2fd01c3ba492c859673e32af8a354cd3a494ce12d1132f:200"),
  //     // child: Image.network(this.job.company.urlLogo),
  //   );
  // }

  Widget _infoJobTexts(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Text(
        //   // this.job.company.name,
        //   "Netflix",
        //   style: Theme.of(context).textTheme.subtitle1,
        // ),
        Text(
          // this.job.role,
          transaction.comments,
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(height: 3.0),
        Row(
          children: <Widget>[
            Icon(
              Icons.calendar_today,
              color: Theme.of(context).highlightColor,
              size: 14.0,
            ),
            const SizedBox(width: 3.0),
            Text(
              // this.job.location,
              '${transaction.date.day}/${transaction.date.month}/${transaction.date.year} ${transaction.date.hour}:${transaction.date.minute}',
              style: Theme.of(context).textTheme.subtitle1,
            )
          ],
        ),
      ],
    );
  }

  Widget _favIcon(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, right: 20.0),
      child: Icon(
        Icons.favorite_border,
        color: Theme.of(context).highlightColor,
      ),
    );
  }
}
