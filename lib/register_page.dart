import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todo_frontend_app/config.dart';
import 'package:todo_frontend_app/login_page.dart';
import 'app_logo.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;

  void registerUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var regBody = {
        "email": emailController.text,
        "password": passwordController.text
      };
      var response = await http.post(
        Uri.parse(registeration),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(regBody),
      );

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if (jsonResponse['status'] == true) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
        print("Going to Login Page");
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0XFFF95A3B),
                Color(0XFFF96713),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.8],
              tileMode: TileMode.mirror,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CommonLogo(), // Your app logo widget
                  SizedBox(height: 10), // Replaces HeightBox
                  Text(
                    "CREATE YOUR ACCOUNT",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.yellow[100],
                    ),
                  ),
                  SizedBox(height: 16), // Spacing
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        errorStyle: TextStyle(color: Colors.white),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        hintText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16), // Spacing
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.copy),
                          onPressed: () {
                            // final data =
                            //     ClipboardData(text: passwordController.text);
                            // Clipboard.setData(data);
                          },
                        ),
                        prefixIcon: IconButton(
                          icon: Icon(Icons.password),
                          onPressed: () {
                            // String passGen = generatePassword();
                            // passwordController.text = passGen;
                            // setState(() {});
                          },
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        errorStyle: TextStyle(color: Colors.white),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24), // Spacing
                  GestureDetector(
                    onTap: () {
                      print("registeration attempt");
                      registerUser();
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green[600],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16), // Spacing
                  GestureDetector(
                    onTap: () {
                      print("Sign In");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already Registered?"),
                        Text(
                          " Sign In",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// String generatePassword() {
//   String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
//   String lower = 'abcdefghijklmnopqrstuvwxyz';
//   String numbers = '1234567890';
//   String symbols = '!@#\$%^&*()<>,./';

//   String password = '';

//   int passLength = 20;

//   String seed = upper + lower + numbers + symbols;

//   List<String> list = seed.split('').toList();

//   Random rand = Random();

//   for (int i = 0; i < passLength; i++) {
//     int index = rand.nextInt(list.length);
//     password += list[index];
//   }
//   return password;
// }