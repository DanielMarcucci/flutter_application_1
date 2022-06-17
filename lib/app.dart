// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/providers/provider.dart';
// // import 'package:flutter_application_1/screens/forgot_password.dart';
// import 'package:flutter_application_1/screens/home_screen.dart';
// import 'package:flutter_application_1/screens/login/login_screen.dart';
// // import 'package:flutter_application_1/screens/signup_screen.dart';
// import 'package:flutter_application_1/services/auth_service.dart';

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Provider(
//       child: MaterialApp(
//         title: "Rest Auth",
//         home: FutureBuilder(
//           future: AuthService.getToken(),
//           builder: (_, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasData) {
//               return HomeScreen();
//             } else {
//               return LoginScreen();
//             }
//           },
//         ),
//         routes: {
//           '/home': (_) => HomeScreen(),
//           '/login': (_) => LoginScreen(),
//           // '/signup': (_) => new SignupScreen(),
//           // '/forgot_password': (_) => new ForgotPassword(),
//         },
//       ),
//     );
//   }
// }