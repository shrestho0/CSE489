import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  // final List<String> dummyInviteCodes = [
  //   "jj2cb",
  //   "s7neb",
  //   "xw90d",
  //   "wbwq6",
  //   "tss7u"
  // ];

  /// generate random 6 digit alphanumeric code

  // int dummyIdx = 0;

  // generate random number between 0 to 4
  // void dummyRandomIdx() {
  //   setState(() {
  //     dummyIdx = (dummyIdx + 1) % 5;
  //   });
  // }

  final inviteEditingController = TextEditingController();
  String? invitationCode;

  // void createInvitations() {
  //   FirebaseFirestore.instance.collection("Invitation").doc().set({
  //     "invitation_code": invitationCode,
  //     "sender_uid": user!.uid,
  //     "receiver_uid": "",
  //     "status": "waiting",
  //     "created_at": DateTime.now(),
  //     "expires_at": DateTime.now().add(const Duration(minutes: 10)),
  //   });
  // }
}

@override
void initState() {
  // TODO: implement initState

  // check if user already has an active invitation code

  if (user != null) {
    final old_data = FirebaseFirestore.instance
        .collection("Invitation")
        .where("sender_uid", isEqualTo: user!.uid)
        .where("expires_at", isGreaterThan: DateTime.now())
        .orderBy("expires_at");
    // if (old_data != null) {
    print("OLD DATA");
    old_data.get().then((querySnapshot) {
      if (querySnapshot.docs.length > 0) {
        invitationCode = querySnapshot.docs[0]["invitation_code"];
      }
      // for (var docSnapshot in querySnapshot.docs) {
      //   print('${docSnapshot.id} => ${docSnapshot.data()}');
      // }
    });
    print("OLD DATA");

    print("user ache, invite kora jabe");
  } else {
    // user already has an active invitation code
    // so, no need to create a new one
    // just use the old one
    // invitationCode = old_data["invitation_code"];
    // }
    invitationCode = randomString(6);

    super.initState();
  }

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
              Text(invitationCode.toString()),
              commonOutlineButton(
                  text: "Share & Play",
                  onPressed: () {
                    Navigator.pushNamed(context, "/confirm-match");

                    // the game page
                  })
            ],
          ),
        ));
  }
}
