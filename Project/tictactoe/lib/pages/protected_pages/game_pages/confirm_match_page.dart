import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/utils/Utils.dart';

class ConfirmMatchPage extends StatefulWidget {
  const ConfirmMatchPage({super.key});

  @override
  State<ConfirmMatchPage> createState() => _ConfirmMatchPageState();
}

class _ConfirmMatchPageState extends State<ConfirmMatchPage> {
  User? user = FirebaseAuth.instance.currentUser;

  final inviteEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonProtectedAppbar(
            title: "Ready to play!",
            context: context,
            user: user,
            leading: false),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Match Found!!"),
              commonOutlineButton(
                  text: "Start Match",
                  onPressed: () {
                    Navigator.pushNamed(context, "/the-game-page");
                  })
            ],
          ),
        ));
  }
}
