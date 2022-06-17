import 'dart:convert';

import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/login/components/background.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_auth/Screens/Login/components/background.dart';
// import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_application_1/components/rounded_button.dart';
import 'package:flutter_application_1/components/rounded_input_field.dart';
import 'package:flutter_application_1/components/rounded_password_field.dart';
// import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  @override
  createState() {
    return _Body();
  }
}

class _Body extends State<Body> {
  String identifier = "";
  String password = "";

  // _Body({
  //   Key? key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
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
            // SvgPicture.asset(
            //   "assets/icons/login.svg",
            //   height: size.height * 0.35,
            // ),
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
                // debugPrint("se queda");
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   debugPrint("pasa");
                //   return HomeScreen();
                // }));
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
    );
  }

  dynamic login(BuildContext context) async {
    AuthService authInfo = AuthService();

    final res = await authInfo.login(identifier, password);
    final data = jsonDecode(res) as Map<String, dynamic>;

    if (data['status'] != 200) {
      // addError(data['message']);
      debugPrint("error");
    } else {
      // AuthService.setToken(data['token'], data['refreshToken']);
      // Navigator.pushNamed(context, '/home');
      return data;
    }
  }
}
