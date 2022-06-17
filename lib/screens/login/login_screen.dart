// import 'package:flutter_application_1/screens/login/components/body.dart';
// import 'package:flutter/material.dart';

// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Body(),
//     );
//   }
// }
import 'dart:convert';

import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_application_1/models/auth_data.dart';
import 'package:flutter_application_1/models/customer.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/login/components/background.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_auth/Screens/Login/components/background.dart';
// import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_application_1/components/rounded_button.dart';
import 'package:flutter_application_1/components/rounded_input_field.dart';
import 'package:flutter_application_1/components/rounded_password_field.dart';
import 'package:flutter_application_1/services/customer_service.dart';
// import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  String identifier = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "INICIAR SESIÓN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              Image.asset('assets/images/splash_1.jpg'),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Tu usuario",
                onChanged: (value) {
                  setState(() {
                    identifier = value;
                  });
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              RoundedButton(
                text: "Ingresar",
                press: () {
                  login(context);
                },
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: size.height * 0.03),
              // AlreadyHaveAnAccountCheck(
              //   press: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) {
              //           // return SignUpScreen();
              //           return HomeScreen();
              //         },
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // _Body({
  //   Key? key,
  // }) : super(key: key);

  dynamic login(BuildContext context) async {
    AuthService authService = AuthService();

    final res = await authService.login(identifier, password);
    final data = jsonDecode(res) as Map<String, dynamic>;

    if (data['statusCode'] == 400) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: Text(data["message"][0]["messages"][0]["message"]),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      final AuthData authData = AuthData.fromJson(data);
      AuthService.setAuthData(authData.jwt, authData.user);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const HomeScreen();
      }));
      return data;
    }
  }
}
