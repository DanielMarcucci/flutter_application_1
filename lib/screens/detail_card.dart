import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/card_component.dart';
import 'package:flutter_application_1/components/text_field_container.dart';
import 'package:flutter_application_1/models/account.dart';
import 'package:flutter_application_1/services/account_service.dart';

class DetailCard extends StatefulWidget {
  const DetailCard({Key? key, required this.account}) : super(key: key);

  final Account account;

  @override
  createState() {
    return _DetailCard();
  }
}

class _DetailCard extends State<DetailCard> {
  late Future<dynamic> futureAccounts;

  late String amountValue;
  late String commentsValue;
  late String dateValue;
  late String authorizationCodeValue;
  late String pinVerifiedValue;

  String _selectedRelatedAccountIdValue = '';

  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    futureAccounts = AccountService.findNotEqual(widget.account.id);

    // final customerRes = await CustomerService.find();
    // final customerData = jsonDecode(customerRes) as Map<String, dynamic>;
    // final Customer customer = Customer.fromJson(customerData);
  }

  @override
  Widget build(BuildContext context) {
    var dateNow = DateTime.now();
    dateValue = DateTime.utc(dateNow.year, dateNow.month, dateNow.day,
            dateNow.hour, dateNow.minute, dateNow.second, dateNow.millisecond)
        .toIso8601String();

    debugPrint(dateValue);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 150),
                        Text(
                          'Transferir',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 56,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const Divider(color: Colors.black38),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Password'),
                                  obscureText: true,
                                  validator: (value) => value!.isEmpty
                                      ? 'Password cannot be blank'
                                      : null,
                                  // onSaved: (value) => _password = value,
                                ),
                                TextFieldContainer(
                                    child: TextFormField(
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                      labelText: "Monto:",
                                      border: InputBorder.none),
                                  onSaved: (value) {
                                    amountValue = value!;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "El monto es requerido";
                                    }
                                    return null;
                                  },
                                )),
                                TextFieldContainer(
                                    child: _dropdownAccounts(context)),
                                TextFieldContainer(
                                    child: TextFormField(
                                  style: const TextStyle(color: Colors.black),
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                      labelText: "Comentarios",
                                      border: InputBorder.none),
                                  onSaved: (value) {
                                    commentsValue = value!;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Los comentarios son requeridos";
                                    }
                                  },
                                )),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Validate returns true if the form is valid, or false otherwise.
                                      // if (_formKey.currentState!.validate()) {
                                      // If the form is valid, display a snackbar. In the real world,
                                      // you'd often call a server or save the information in a database.
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Processing Data')),
                                      );
                                      // }
                                    },
                                    child: const Text('Submit'),
                                  ),
                                ),
                              ],
                            )),
                        // SizedBox(height: 32),
                        // Text(
                        //   // planetInfo.description ?? '',
                        //   '',
                        //   maxLines: 5,
                        //   overflow: TextOverflow.ellipsis,
                        //   style: TextStyle(
                        //     fontFamily: 'Avenir',
                        //     fontSize: 20,
                        //     color: Theme.of(context).primaryColor,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        // SizedBox(height: 32),
                        // Divider(color: Colors.black38),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 32.0),
                  //   child: Text(
                  //     'Gallery',
                  //     style: TextStyle(
                  //       fontFamily: 'Avenir',
                  //       fontSize: 25,
                  //       color: const Color(0xff47455f),
                  //       fontWeight: FontWeight.w300,
                  //     ),
                  //     textAlign: TextAlign.left,
                  //   ),
                  // ),
                  // Container(
                  //   height: 250,
                  //   padding: const EdgeInsets.only(left: 32.0),
                  //   child: ListView.builder(
                  //       itemCount: 0,
                  //       scrollDirection: Axis.horizontal,
                  //       itemBuilder: (context, index) {
                  //         return Card(
                  //           clipBehavior: Clip.antiAlias,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(24),
                  //           ),
                  //           child: AspectRatio(
                  //               aspectRatio: 1,
                  //               child: Image.network(
                  //                 'https://logos-marcas.com/wp-content/uploads/2020/09/Mastercard-Logo.png',
                  //                 fit: BoxFit.cover,
                  //               )),
                  //         );
                  //       }),
                  // ),
                ],
              ),
            ),
            // CardComponent(account: account),
            Column(
              children: [
                CardComponent(account: widget.account),
              ],
            ),
            // Positioned(
            //   right: -64,
            //   child: Hero(
            //       tag: 100, child: Image.asset('assets/icons/Visa-Logo.png')),
            // ),
            // Positioned(
            //   top: 60,
            //   left: 32,
            //   child: Text(
            //     '5',
            //     style: TextStyle(
            //       fontFamily: 'Avenir',
            //       fontSize: 247,
            //       color: Theme.of(context).highlightColor,
            //       fontWeight: FontWeight.w900,
            //     ),
            //     textAlign: TextAlign.left,
            //   ),
            // ),
            Positioned(
              right: 12,
              top: 25,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  // void _save(BuildContext context) {
  //   if (_formKey.currentState!.validate()) {
  // }

  Widget _dropdownAccounts(context) {
    return FutureBuilder<dynamic>(
      future: futureAccounts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          debugPrint(snapshot.data!);
          final List<dynamic> accountsData =
              jsonDecode(snapshot.data!) as List<dynamic>;

          return DropdownButtonFormField(
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                  labelText: "Acreditar a:", border: InputBorder.none),
              value: _selectedRelatedAccountIdValue,
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  _selectedRelatedAccountIdValue = value.toString();
                });
              },
              onSaved: (value) {
                setState(() {
                  _selectedRelatedAccountIdValue = value.toString();
                });
              },
              validator: (value) {
                if (value.toString().isEmpty) {
                  return "No puede estar vacío";
                } else {
                  return null;
                }
              },
              items: _menuItemsAccounts(accountsData));
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }

  List<DropdownMenuItem<String>> _menuItemsAccounts(
      List<dynamic> accountsData) {
    List<DropdownMenuItem<String>> dropdownItems = [];
    dropdownItems
        .add(const DropdownMenuItem(value: '', child: Text('Seleccionar uno')));

    dropdownItems.addAll(accountsData.map((e) {
      final Map<String, dynamic> accountData = e as Map<String, dynamic>;
      final Account account = Account.fromJson(accountData);
      return DropdownMenuItem(
        value: account.id.toString(),
        child: Text(account.accountNumber + ' - ' + account.alias),
      );
    }));

    return dropdownItems;
  }
}
