import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/pages/auth_pages/login_page.dart';
import 'package:tictactoe/pages/protected_pages/home_page.dart';

class AuthHandlerPage extends StatelessWidget {
  const AuthHandlerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}

// Utilities

void signOut() {
  // print("user signing out ${FirebaseAuth.instance.currentUser.email}");
  FirebaseAuth.instance.signOut();
  //
}
