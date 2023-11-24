import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/services/auth_services.dart';
import 'package:tictactoe/utils/Utils.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Input controllers
  final emailInputController = TextEditingController();

  final passwordInputController = TextEditingController();

  void customDialogueWithMessage(String message) {
    //
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
          );
        });
  }

  void handleSignIn({bool google = false}) async {
    // dialogue

    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailInputController.text,
        password: passwordInputController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        customDialogueWithMessage("User not found.");
      } else if (e.code == 'wrong-password') {
        customDialogueWithMessage("Wrong password");
      } else if (e.code == "channel-error") {
        customDialogueWithMessage("channel-error");
      } else {
        customDialogueWithMessage(e.code);
      }
    } catch (e) {
      print("error catch korte parini");
      // fuck it
    }
    Navigator.pop(context);

    // no dialogue
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "`tictactoe`",
            style: TextStyle(
              fontSize: 30,
              fontFamily: "Arcade",
            ),
          ),
          const Text(
            "Online `tictactoe` game for cse470 project",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
          const Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Image(
                image: AssetImage('assets/ic_launcher.png'),
                height: 100,
                width: 100,
              ),
            ),
          ),
          someFreeSpace(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextField(
                    controller: emailInputController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter Email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextField(
                    controller: passwordInputController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter Password',
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      {Navigator.pushNamed(context, "/forgot-password")},
                  child: Container(
                    alignment: Alignment.topRight,
                    child: const Text("Forgot password?"),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: OutlinedButton(
                    onPressed: handleSignIn,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      )),
                    ),
                    child: const Text("Sing In"),
                  ),
                ),
              ],
            ),
          ),
          const Flexible(
            child: Text(
              "or",
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              children: [
                Container(
                  child: OutlinedButton(
                    onPressed: () => AuthServices().signInWithGoogle(),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image(
                          image: AssetImage('assets/google_icon.png'),
                          height: 20,
                          width: 20,
                        ),
                        const Text("Sign In/Up With Google"),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: OutlinedButton(
                    onPressed: () => Navigator.pushNamed(context, "/register"),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      )),
                    ),
                    child: const Text("Sign Up with email"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
