import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/utils/Utils.dart';

class ReMatchOrEndSessionPage extends StatefulWidget {
  const ReMatchOrEndSessionPage({super.key});

  @override
  State<ReMatchOrEndSessionPage> createState() =>
      _ReMatchOrEndSessionPageState();
}

class _ReMatchOrEndSessionPageState extends State<ReMatchOrEndSessionPage> {
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
