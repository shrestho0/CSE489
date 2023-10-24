import 'package:_t03_firebase_auth_actually/services/firebase_auth.dart';
import 'package:_t03_firebase_auth_actually/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final _auth = FirebaseAuthService();
  final User? user = FirebaseAuthService().getUser;

  @override
  Widget build(BuildContext context) {
    print(user);
    print(_auth);
    return Scaffold(
      appBar: AppUtils.commonAppBar("User Home Page"),
      body: Container(
        child: Column(
          children: [
            Text("Logged in user page "),
            Text("mf logged in as ${user?.email}"),
            ElevatedButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
              child: Text("Sign Out mf!@#"),
            ),
          ],
        ),
      ),
    );
  }
}
