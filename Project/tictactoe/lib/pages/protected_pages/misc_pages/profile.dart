import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/utils/Utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  final displayNameController = TextEditingController();
  final emailEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    displayNameController.text = user?.displayName ?? "";
    emailEditingController.text = user?.email ?? "";
    return Scaffold(
        appBar: commonProtectedAppbar(
            title: "", context: context, user: user, leading: false),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Column(
                      children: [
                        commonOutlineButton(
                            text: "Back to home page",
                            onPressed: () {
                              Navigator.pushNamed(context, '/');
                            },
                            icon: Icon(Icons.home)),
                        commonOutlineButton(
                            text: "Logout!",
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              // Navigator.pushNamedAndRemoveUntil(
                              //     context, "/login", (route) => false);
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/', (route) => false);
                            },
                            icon: Icon(Icons.logout)),
                      ],
                    )),
                GestureDetector(
                  onTap: () {
                    showCustomDialog(
                        context: context,
                        title: "Display Image",
                        description: "Features will be added later",
                        popText: "Okhay!");
                  },
                  child: ClipOval(
                    child: user?.photoURL != null
                        ? Image.network(
                            user!.photoURL.toString(),
                            height: 100,
                            width: 100,
                          )
                        : const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.black87,
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white70,
                            ),
                          ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      commonTextInputs(
                        theController: displayNameController,
                        labelText: "Display Name",
                      ),
                      commonTextInputs(
                        theController: emailEditingController,
                        labelText: "Email Name",
                      ),
                    ],
                  ),
                ),
                commonOutlineButton(
                    text: "Save Profile",
                    onPressed: () {
                      user?.updateDisplayName(displayNameController.text);
                      // save the profile
                    })
              ],
            ),
          ),
        ));
  }
}
