import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/utils/Utils.dart';

class InviteSomeonePage extends StatefulWidget {
  const InviteSomeonePage({super.key});

  @override
  State<InviteSomeonePage> createState() => _InviteSomeonePageState();
}

class _InviteSomeonePageState extends State<InviteSomeonePage> {
  User? user = FirebaseAuth.instance.currentUser;
  final List<String> dummyInviteCodes = [
    "jj2cb",
    "s7neb",
    "xw90d",
    "wbwq6",
    "tss7u"
  ];

  int dummyIdx = 0;

  // generate random number between 0 to 4
  void dummyRandomIdx() {
    setState(() {
      dummyIdx = (dummyIdx + 1) % 5;
    });
  }

  final inviteEditingController = TextEditingController();
  String? invitationCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonProtectedAppbar(
            title: "Join with Codes", context: context, user: user),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(dummyInviteCodes[dummyIdx]),
              commonOutlineButton(
                  text: "Generate Code", onPressed: dummyRandomIdx),
              commonOutlineButton(
                  text: "Find & Play",
                  onPressed: () {
                    Navigator.pushNamed(context, "/confirm-match");

                    // the game page
                  })
            ],
          ),
        ));
  }
}
