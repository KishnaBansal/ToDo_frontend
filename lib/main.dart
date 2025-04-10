import 'package:flutter/material.dart';
import 'package:todo_frontend_app/login_page.dart';
import 'package:todo_frontend_app/register_page.dart';
// import 'package:todo_frontend_app/registeration.dart';
// import 'package:flutter_todo_app/dashboard.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'loginPage.dart';

void main() async {
  //  WidgetsFlutterBinding.ensureInitialized();
  //  SharedPreferences prefs = await SharedPreferences.getInstance();
  // runApp(MyApp(token: prefs.getString('token'),));
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   // final token;
//   const MyApp({
//     // @required this.token,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primaryColor: Colors.black,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         // home: (token != null && JwtDecoder.isExpired(token) == false)
//         //     ? Dashboard(token: token)
//         //     : SignInPage();
//         home: 
//     );
//   }
// }


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: (token != null && JwtDecoder.isExpired(token) == false)
        //     ? Dashboard(token: token)
        //     : SignInPage();
        home: RegistrationPage()
    );
  }
}