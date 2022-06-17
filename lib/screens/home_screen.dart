import 'dart:convert';
import 'dart:math';

import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_application_1/components/card_carousel.dart';
import 'package:flutter_application_1/components/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/account.dart';
import 'package:flutter_application_1/models/customer.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/login/login_screen.dart';
import 'package:flutter_application_1/services/account_service.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/services/customer_service.dart';
import 'package:flutter_application_1/services/transaction_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  late Future<String> futureUsername;
  late Future<dynamic> futureCustomer;
  late Future<dynamic> futureTransactions;

  Future loadPage() async {
    setState(() => {});
    debugPrint("setCards");
  }

  @override
  void initState() {
    super.initState();
    futureUsername = AuthService.getUsername();
    futureCustomer = CustomerService.find();

    // final customerRes = await CustomerService.find();
    // final customerData = jsonDecode(customerRes) as Map<String, dynamic>;
    // final Customer customer = Customer.fromJson(customerData);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: futureCustomer,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<dynamic> customersData =
              jsonDecode(snapshot.data!) as List<dynamic>;
          final Map<String, dynamic> customerData =
              customersData[0] as Map<String, dynamic>;
          final Customer customer = Customer.fromJson(customerData);

          return Scaffold(
            body: SafeArea(
              child: ListView(
                children: <Widget>[
                  // FutureBuilder(
                  //     future: Future.delayed(Duration(
                  //         seconds:
                  //             2)), // here you provide your future. In your case Provider.of<PeopleModel>(context).fetchPeople()
                  //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //       if (snapshot.connectionState == ConnectionState.waiting) {
                  //         return CircularProgressIndicator();
                  //       }
                  //       if (snapshot.hasError) {
                  //         return Text('ERROR');
                  //       }
                  //       // DATA is in snapshot.data
                  //       return Text('SUCCESS');
                  //     }),

                  _textsHeader(context, customer),
                  _cards(context, customer.id),
                  _recent(context, customer.id),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text(
            '${snapshot.error}',
            style: Theme.of(context).textTheme.bodyText1,
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }

  // Widget _customAppBar() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
  //     child: Row(
  //       children: <Widget>[
  //         IconButton(onPressed: onPressed, icon: icon)
  //       ],
  //     ),
  //     )
  // }
  // Widget _header(context) {
  //   return FutureBuilder<dynamic>(
  //     future: futureCustomer,
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         final List<dynamic> customersData =
  //             jsonDecode(snapshot.data!) as List<dynamic>;
  //         final Map<String, dynamic> customerData =
  //             customersData[0] as Map<String, dynamic>;
  //         final Customer customer = Customer.fromJson(customerData);
  //         // ${snapshot.data!}
  //         return Text(
  //           'Hola ${customer.firstName} ${customer.firstSurname}',
  //           style: Theme.of(context).textTheme.bodyText1,
  //         );
  //       } else if (snapshot.hasError) {
  //         return Text(
  //           '${snapshot.error}',
  //           style: Theme.of(context).textTheme.bodyText1,
  //         );
  //       }

  //       return const CircularProgressIndicator();
  //     },
  //   );
  // }

  Widget _textsHeader(context, Customer customer) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Hola ${customer.firstName} ${customer.firstSurname}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                IconButton(
                    onPressed: () {
                      AuthService.removeToken();
                      Navigator.pop(context);
                      // Navigator.push(
                      //     context,
                      // MaterialPageRoute(
                      //     builder: (context) => LoginScreen()));
                    },
                    icon: const Icon(Icons.logout)),
              ],
            ),
            Text(
              'Haz tu siguiente',
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              'transferencia',
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ));
  }

  Widget _cards(context, int customerId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            'Tarjetas',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        _customerAccounts(context, customerId)
      ],
    );
  }

  Widget _customerAccounts(context, int customerId) {
    return FutureBuilder<dynamic>(
      future: AccountService.find(customerId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          debugPrint(snapshot.data!);
          final List<dynamic> accountsData =
              jsonDecode(snapshot.data!) as List<dynamic>;

          return CardCarousel(
            accountsData: accountsData,
            onRefresh: loadPage,
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _recent(context, int customerId) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              left: 30.0, right: 30.0, top: 5.0, bottom: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                'Recientes',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                'Ver todas',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: _transactions(context, customerId),
          // child: TransactionList(),
          // child: JobList(this.recentJobs),
        ),
      ],
    );
  }

  Widget _transactions(context, int customerId) {
    return FutureBuilder<dynamic>(
      future: TransactionService.findByCustomerId(customerId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          debugPrint(snapshot.data!);
          final List<dynamic> transactionsData =
              jsonDecode(snapshot.data!) as List<dynamic>;

          return TransactionList(transactionsData: transactionsData);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
