import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/models/account.dart';

class CardComponent extends StatelessWidget {
  const CardComponent({Key? key, required this.account}) : super(key: key);

  final Account account;

  @override
  Widget build(BuildContext context) {
    String textName = account.card == null ? account.alias : account.card!.name;
    String textCurrency =
        account.currency == null ? 'Q' : account.currency!.symbol;

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Container(
          decoration: _boxDecoration(context),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(textName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
                _infoCardTexts(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      NumberFormat.currency(symbol: textCurrency)
                          .format(account.currentBalance),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    _cardTypeLogo()
                  ],
                )
              ],
            ),
          ),
        ));
  }

  String numberFormatterToCard(String numberCard) {
    String buffer = '';
    for (int i = 0; i < numberCard.length; i++) {
      buffer += (numberCard[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != numberCard.length) {
        buffer += ('  ');
      }
    }
    return buffer;
  }

  BoxDecoration _boxDecoration(context) {
    return BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black45, offset: Offset(4, 4), blurRadius: 10)
        ]);
  }

  Widget _cardTypeLogo() {
    if (account.card == null) {
      return const SizedBox();
    }

    String textIcon = account.card!.cardTypeId == 1
        ? 'assets/icons/Visa-Logo.png'
        : 'assets/icons/Mastercard-Logo.png';
    return ClipRRect(
        child: Image.asset(
      textIcon,
      width: 60,
    ));
    // return ClipRRect(
    //   child: Image.network(
    //     'https://logos-marcas.com/wp-content/uploads/2020/09/Mastercard-Logo.png',
    //     // https://www.montyhalls.co.uk/wp-content/uploads/2014/11/logo-visa.png
    //     width: 60,
    //   ),
    // );
  }

  Widget _infoCardTexts(context) {
    String textNumber;
    String textDate;
    if (account.card == null) {
      textNumber = account.accountNumber;
      textDate = 'Número de Cuenta';
    } else {
      textNumber = numberFormatterToCard(account.card!.cardNumber);
      textDate = account.card!.authExpDate.month.toString().padLeft(2, '0') +
          '/' +
          account.card!.authExpDate.year.toString().substring(2, 4);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(textNumber, style: Theme.of(context).textTheme.headline3),
        Text(
          textDate,
          style: const TextStyle(fontSize: 13, color: Color(0XFFB7B7D2)),
        )
      ],
    );
  }
}
