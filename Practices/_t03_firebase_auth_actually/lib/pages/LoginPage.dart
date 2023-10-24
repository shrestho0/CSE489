import 'package:_t03_firebase_auth_actually/services/firebase_auth.dart';
import 'package:_t03_firebase_auth_actually/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuthService _auth = FirebaseAuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuthService().getUser;
    if (user != null) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUtils.commonAppBar("Login Page"),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
              ),
            ),
            GestureDetector(
              onTap: handleSignIn,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                color: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: Alignment.center,
                child: Text(
                  "Login ",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void handleSignIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.signIn(email, password);

    if (user != null) {
      print("User signed in!");
      Navigator.pushNamed(context, '/user_home_page');
    }

    print("mf trying to signin with $email, $password");
  }
}
