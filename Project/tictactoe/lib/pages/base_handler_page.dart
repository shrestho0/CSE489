import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/pages/auth_pages/login_page.dart';
import 'package:tictactoe/pages/protected_pages/home_page.dart';
import 'package:tictactoe/pages/protected_pages/misc_pages/error_page.dart';
import 'package:tictactoe/utils/Constants.dart';

///
/// This will check internet, auth, and return the appropriate page
///
class BaseHandler extends StatefulWidget {
  const BaseHandler({super.key});

  @override
  State<BaseHandler> createState() => _BaseHandlerState();
}

class _BaseHandlerState extends State<BaseHandler> {
  // MultiProvider(

  late StreamSubscription<ConnectivityResult> subscription;
  // internet connected
  late bool _internetConnected = false;
  // auth will be handled by firebase

  setInternetStatus(bool value) {
    _internetConnected = value;
    setState(() {});
  }

  @override
  initState() {
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        // not connected to any network,

        setInternetStatus(false);
      } else {
        // connected to some network
        // assuming that it is connected to internet
        // TODO: check if it is connected to internet
        setInternetStatus(true);
      }
      print("[[[ new connectivity result ]]]: $result");
      // // Got a new connectivity status!
    });
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_internetConnected) {
      return _authHandler();
    } else {
      return _offlineHandler();
    }
  }

  Widget _offlineHandler() {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Image(
                image: AssetImage('assets/ic_launcher.png'),
                height: 100,
                width: 100,
                // ),
              ),
            ),
            SizedBox(height: 50),
            Flexible(
              child: Text("No Internet",
                  style: TextStyle(
                      fontSize: 30, color: AppConstants.primaryMainColor)),
            ),
            Text("Can't use app without internet"),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget _offlineHandler() {
  Widget _authHandler() {
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

// Utilities
  void signOut() {
    // print("user signing out ${FirebaseAuth.instance.currentUser.email}");
    FirebaseAuth.instance.signOut();
    //
  }
}
