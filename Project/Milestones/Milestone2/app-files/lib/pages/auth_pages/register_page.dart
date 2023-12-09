import 'package:flutter/material.dart';
import 'package:tictactoe/services/auth_services.dart';
import 'package:tictactoe/utils/Utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //   // Input controllers
  final emailInputController = TextEditingController();

  final passwordInputController = TextEditingController();
  final password2InputController = TextEditingController();

  bool hasError = false;
  String errorMessage = "";

  @override
  void dispose() {
    emailInputController.dispose();
    passwordInputController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    errorMessage = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: const EdgeInsets.only(top: 200),
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
// page title
              authPageTitle("Register"),
              someFreeSpace(height: 10.0, flexible: false),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    commonTextInputs(
                      theController: emailInputController,
                      labelText: "Email",
                      hintText: "Enter Email",
                      onChanged: clearError,
                    ),
                    commonTextInputs(
                      theController: passwordInputController,
                      labelText: "Password",
                      hintText: "Enter Password",
                      obscureText: true,
                      onChanged: clearError,
                    ),
                    commonTextInputs(
                      theController: password2InputController,
                      labelText: "Confirm Password",
                      hintText: "Enter Password",
                      obscureText: true,
                      onChanged: clearError,
                    ),

                    GestureDetector(
                      onTap: () =>
                          {Navigator.pushNamed(context, "/forgot-password")},
                      child: Container(
                        alignment: Alignment.topRight,
                        child: const Text("Forgot password?"),
                      ),
                    ),

                    /// Error message
                    Text(errorMessage),

                    /// Buttons
                    someFreeSpace(height: 10, flexible: false),
                    commonOutlineButton(
                      text: "Sign up!",
                      onPressed: () async {
                        //
                        if (passwordInputController.text !=
                            password2InputController.text) {
                          setState(() {
                            hasError = true;
                            errorMessage = "Passwords do not match";
                          });
                          return;
                        }

                        print("logging in");
                        setState(() {
                          errorMessage = "logging in...";
                        });
                        dynamic something = await AuthServices()
                            .signUpWithPassword(
                                email: emailInputController.text,
                                password: passwordInputController.text);
                        if (something[0] == true) {
                          print("Logged in, going back");
                          Navigator.pop(context);
                        } else {
                          setState(() {
                            hasError = true;
                            errorMessage = something[1];
                          });
                          print(
                              "Error here!! something went wrong: ${something[1]}");
                        }
                      },
                    ),
                    someFreeSpace(height: 10, flexible: false),
                    commonOutlineButton(
                      text: "Back to other options",
                      onPressed: () => {Navigator.pop(context)},
                      icon: Icon(Icons.chevron_left),
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }

  void clearError(dynamic _) {
    setState(() {
      hasError = false;
      errorMessage = "";
    });
  }
}
