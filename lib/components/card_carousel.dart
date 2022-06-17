import 'package:flutter_application_1/components/card_item.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_1/models/account.dart';

class CardCarousel extends StatelessWidget {
  const CardCarousel(
      {Key? key, required this.accountsData, required this.onRefresh})
      : super(key: key);

  final List<dynamic> accountsData;
  final Future Function() onRefresh;

  // final Map<String, dynamic> accountData =
  //     accountsData[0] as Map<String, dynamic>;
  // final Account account = Customer.fromJson(accountData);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          enableInfiniteScroll: false,
          reverse: false,
          viewportFraction: 0.86,
          height: 230),
      items: accountsData.map((e) {
        final Map<String, dynamic> accountData = e as Map<String, dynamic>;
        final Account account = Account.fromJson(accountData);
        return CardItemComponent(
          account: account,
          onRefresh: onRefresh,
        );
      }).toList(),
      // items: <Widget>[
      //   CardItemComponent(),
      //   CardItemComponent(),
      //   CardItemComponent(),
      // ],
    );
  }
}
