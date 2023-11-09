import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/services/auth_services.dart';

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

    if (google) {
      AuthServices().signInWithGoogle();
    } else {
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
        } else {
          customDialogueWithMessage(e.code);
        }
        print(e.code);
      } catch (e) {
        // fuck it
      }
      Navigator.pop(context);
    }

    // no dialogue
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(
            flex: 1,
          ),
          const Flexible(
            flex: 2,
            child: Image(
              image: AssetImage('lib/assets/ic_launcher.png'),
              height: 150,
              width: 150,
            ),
          ),
          const Text("some text or whatever"),
          TextField(
            controller: emailInputController,
          ),
          TextField(
            controller: passwordInputController,
          ),
          Container(
            alignment: Alignment.topRight,
            child: const Text("Forgot password?"),
          ),
          OutlinedButton(
            onPressed: handleSignIn,
            child: Text("Sign in"),
          ),
          const Text(
            "or",
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
              onPressed: () => handleSignIn(google: true),
              child: Text("sing in with google"))
        ],
      ),
    );
  }
}
