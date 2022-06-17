import 'package:flutter/material.dart';

import 'login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset('assets/images/splash_1.jpg'),
                Column(
                  children: [
                    Text(
                      'Transferencia',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      'de dinero fácil',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
                MaterialButton(
                  elevation: 10,
                  minWidth: 170,
                  height: 50,
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    'Empezar',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                  },
                )
              ],
            )));
  }
}
