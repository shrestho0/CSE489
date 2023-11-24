import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tictactoe/services/auth_services.dart';
import 'package:tictactoe/utils/Utils.dart';

enum PreLoginStates { Nothing, AwaitLogin, Loading, Error }

enum PreLoginTypes { Nothing, EmailLogin, GoogleLogin }

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Input controllers
  final emailInputController = TextEditingController();

  final passwordInputController = TextEditingController();

  bool showEmailPasswordInput = false;

  PreLoginStates preLoginState = PreLoginStates.Nothing;
  PreLoginTypes preLoginTypes = PreLoginTypes.Nothing;

  String errorMessage = "";

  void setLoginError(String msg) {
    preLoginState = PreLoginStates.Error;
    setState(() {
      errorMessage = msg;
    });
  }

  void handleSignIn({bool google = false}) async {
    setState(() {
      preLoginState = PreLoginStates.Loading;
      preLoginTypes =
          google ? PreLoginTypes.GoogleLogin : PreLoginTypes.EmailLogin;
      errorMessage = "";
    });

    if (google) {
      // d

      await AuthServices().signInWithGoogle();
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailInputController.text,
        password: passwordInputController.text,
      );
      setState(() {
        preLoginState = PreLoginStates.Nothing;
        errorMessage = "";
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setLoginError("User not found.");
      } else if (e.code == 'wrong-password') {
        setLoginError("Wrong password");
      } else if (e.code == "channel-error") {
        setLoginError("channel-error");
      } else {
        setLoginError(e.code);
      }
    } catch (e) {
      print("error catch korte parini");
      // fuck it
    }
    // Navigator.pop(context);

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
          // TODO: COMMENT after debugging
          Text("${preLoginState} ${preLoginTypes}"),
          // TODO: UNCOMMENT after debugging
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
            child: preLoginTypes == PreLoginTypes.Nothing
                ? null
                : Column(
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
                    ],
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              children: [
                // Container(
                //   padding: const EdgeInsets.symmetric(vertical: 10),
                //   child: OutlinedButton(
                //     onPressed: handleSignIn,
                //     style: OutlinedButton.styleFrom(
                //       minimumSize: const Size.fromHeight(50),
                //       backgroundColor: Colors.black87,
                //       foregroundColor: Colors.white,
                //       shape: const RoundedRectangleBorder(
                //           borderRadius: BorderRadius.all(
                //         Radius.circular(5),
                //       )),
                //     ),
                //     child: const Text("Login in with email"),
                //   ),
                // ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        if (preLoginState == PreLoginStates.Nothing &&
                            preLoginTypes == PreLoginTypes.Nothing) {
                          setState(() {
                            preLoginTypes = PreLoginTypes.EmailLogin;
                            preLoginState = PreLoginStates.AwaitLogin;
                          });
                        } else if (preLoginState == PreLoginStates.AwaitLogin &&
                            preLoginTypes == PreLoginTypes.EmailLogin) {
                          handleSignIn();
                        }
                      });
                      // if (showEmailPasswordInput == true) {
                      //   handleSignIn();
                      // } else {
                      //   setState(() {
                      //     showEmailPasswordInput = true;
                      //   });
                      // }
                    },
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image(
                        //   image: AssetImage('assets/google_icon.png'),
                        //   height: 20,
                        //   width: 20,
                        // ),
                        Icon(Icons.login),
                        (preLoginState == PreLoginStates.Loading)
                            ? Text(" Signing in... ")
                            : Text("  Login with email  "),
                      ],
                    ),
                  ),
                ),
                !(preLoginState == PreLoginStates.AwaitLogin)
                    ? someFreeSpace(height: 2)
                    : Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              preLoginState = PreLoginStates.Nothing;
                              preLoginTypes = PreLoginTypes.Nothing;
                            });
                          },
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
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Image(
                              //   image: AssetImage('assets/google_icon.png'),
                              //   height: 20,
                              //   width: 20,
                              // ),
                              Icon(Icons.arrow_back),
                              Text(" Back to other options "),
                            ],
                          ),
                        ),
                      ),
                !(preLoginTypes == PreLoginTypes.Nothing)
                    ? someFreeSpace(height: 2)
                    : Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: OutlinedButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, "/register"),
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
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Image(
                              //   image: AssetImage('assets/google_icon.png'),
                              //   height: 20,
                              //   width: 20,
                              // ),
                              Icon(Icons.person_add),
                              Text(" Register with email "),
                            ],
                          ),
                        ),
                      ),
                // Container(
                //   padding: const EdgeInsets.symmetric(vertical: 5),
                //   child: OutlinedButton(
                //     onPressed: () => Navigator.pushNamed(context, "/register"),
                //     style: OutlinedButton.styleFrom(
                //       minimumSize: const Size.fromHeight(50),
                //       backgroundColor: Colors.black87,
                //       foregroundColor: Colors.white,
                //       shape: const RoundedRectangleBorder(
                //           borderRadius: BorderRadius.all(
                //         Radius.circular(5),
                //       )),
                //     ),
                //     child: const Text("Sign Up with email"),
                //   ),
                // ),
                ////
                (preLoginState == PreLoginStates.Nothing ||
                        preLoginTypes == PreLoginTypes.GoogleLogin)
                    ? const Text("==== or ====")
                    : someFreeSpace(height: 2),
                (preLoginState == PreLoginStates.Nothing ||
                        preLoginTypes == PreLoginTypes.GoogleLogin)
                    ? Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: OutlinedButton(
                          onPressed: () => handleSignIn(google: true),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Image(
                                image: AssetImage('assets/google_icon.png'),
                                height: 20,
                                width: 20,
                              ),
                              (preLoginState == PreLoginStates.Loading)
                                  ? const Text(" Signing in... ")
                                  : const Text(" Authenticate With Google"),
                            ],
                          ),
                        ),
                      )
                    : someFreeSpace(height: 2)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
