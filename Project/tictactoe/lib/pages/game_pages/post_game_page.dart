import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/utils/Utils.dart';

class PostGamePage extends StatefulWidget {
  const PostGamePage({super.key});

  @override
  State<PostGamePage> createState() => _PostGamePageState();
}

class _PostGamePageState extends State<PostGamePage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonProtectedAppbar(
            title: "Re-match", context: context, user: user, leading: false),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              commonOutlineButton(
                  text: "Re-match Match",
                  onPressed: () {
                    Navigator.popAndPushNamed(context, "/the-game-page");
                  }),
              commonOutlineButton(
                  text: "End session",
                  onPressed: () {
                    Navigator.popAndPushNamed(context, "/");
                  })
            ],
          ),
        ));
  }
}
