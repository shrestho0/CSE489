import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/pages/auth_pages/login_page.dart';
import 'package:tictactoe/pages/protected_pages/home_page.dart';
import 'package:tictactoe/pages/protected_pages/misc_pages/error_page.dart';

class AuthHandlerPage extends StatelessWidget {
  const AuthHandlerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            try {
              User? user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                FirebaseFirestore.instance
                    .collection("UserStatus")
                    .doc(user.uid)
                    .set({
                  "isOnline": true,
                  "isPlaying": false,
                  "last_online_time": FieldValue.serverTimestamp(),
                });
                // FirebaseFirestore.instance
                //     .collection("users")
                //     .doc(user!.uid)
                //     .get()
                //     .then((value) {
                //   print("user data: ${value.data()}");
                // });
              }
              return const HomePage();
            } catch (e) {
              print("error: $e");
              return const ErrorPage();
            }
          } else {
            return const LoginPage();
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
