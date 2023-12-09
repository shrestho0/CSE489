import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/utils/Utils.dart';

class JoinWithInvitationCodePage extends StatefulWidget {
  const JoinWithInvitationCodePage({super.key});

  @override
  State<JoinWithInvitationCodePage> createState() =>
      _JoinWithInvitationCodePageState();
}

class _JoinWithInvitationCodePageState
    extends State<JoinWithInvitationCodePage> {
  User? user = FirebaseAuth.instance.currentUser;

  final inviteEditingController = TextEditingController();

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: commonTextInputs(
                    theController: inviteEditingController, labelText: "dd"),
              ),
              commonOutlineButton(
                  text: "Find & Play",
                  onPressed: () {
                    // the game page
                    Navigator.pushNamed(context, "/confirm-match");
                  })
            ],
          ),
        ));
  }
}
