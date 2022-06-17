import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/card_component.dart';
import 'package:flutter_application_1/components/rounded_button.dart';
import 'package:flutter_application_1/components/text_field_container.dart';
import 'package:flutter_application_1/models/account.dart';
import 'package:flutter_application_1/services/account_service.dart';
import 'package:flutter_application_1/services/transaction_service.dart';

class TransactionScreen extends StatefulWidget {
  final Account account;

  const TransactionScreen({Key? key, required this.account}) : super(key: key);

  @override
  createState() {
    return _TransactionScreen();
  }
}

class _TransactionScreen extends State<TransactionScreen> {
  late Future<dynamic> futureAccounts;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _amount;
  late String _relatedAccountId = '';
  late String _comments;

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
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              TextFieldContainer(
                                  child: TextFormField(
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                    labelText: "Monto:",
                                    border: InputBorder.none),
                                onSaved: (value) {
                                  _amount = value!;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "El monto es requerido";
                                  }
                                  return null;
                                },
                              )),
                              // input field for password
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
                                  _comments = value!;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Los comentarios son requeridos";
                                  }
                                },
                              )),
                              RoundedButton(
                                text: "Trasferir ahora",
                                press: _validateAndSave,
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                CardComponent(account: widget.account),
              ],
            ),
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

  void _validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      form.save();

      DateTime dateNow = DateTime.now();
      String dateValue = DateTime.utc(dateNow.year, dateNow.month, dateNow.day,
              dateNow.hour, dateNow.minute, dateNow.second, dateNow.millisecond)
          .toIso8601String();

      Random random = Random();
      int authorizationCode = random.nextInt(900000) + 100000;
      int pinVerified = random.nextInt(900) + 100;

      await TransactionService.save({
        "account_id": widget.account.id.toString(),
        "related_account_id": _relatedAccountId,
        "transaction_type_id": '1',
        "currency_id": widget.account.currency!.id.toString(),
        "amount": (num.parse(_amount) * -1).toString(),
        "comments": _comments,
        "date": dateValue,
        "authorization_code": authorizationCode.toString(),
        "pin_verified": pinVerified.toString()
      });

      await TransactionService.save({
        "account_id": _relatedAccountId,
        "related_account_id": widget.account.id.toString(),
        "transaction_type_id": '2',
        "currency_id": widget.account.currency!.id.toString(),
        "amount": _amount,
        "comments": _comments,
        "date": dateValue,
        "authorization_code": authorizationCode.toString(),
        "pin_verified": pinVerified.toString()
      });

      Navigator.pop(context);
    }
  }

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
              value: _relatedAccountId,
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  _relatedAccountId = value.toString();
                });
              },
              onSaved: (value) {
                setState(() {
                  _relatedAccountId = value.toString();
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
