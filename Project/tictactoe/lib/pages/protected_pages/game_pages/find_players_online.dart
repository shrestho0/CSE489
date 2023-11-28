import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/utils/Utils.dart';

class FindPlayersOnline extends StatefulWidget {
  const FindPlayersOnline({super.key});

  @override
  State<FindPlayersOnline> createState() => _FindPlayersOnlineState();
}

class _FindPlayersOnlineState extends State<FindPlayersOnline> {
  User? user = FirebaseAuth.instance.currentUser;
  var counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => x).take(3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonProtectedAppbar(
            title: "Find players", context: context, user: user),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.search),
              const Text("finding online players..."),
              const Text("(wait for 3 seconds)"),
              const Text("...."),
              StreamBuilder(
                stream: counterStream,
                builder: (context, snapshot) {
                  if (snapshot.data != 2) {
                    return CircularProgressIndicator(
                      color: Colors.black87,
                    );
                  } else {
                    return Column(
                      children: [
                        const Text("Player found"),
                        commonOutlineButton(
                            text: "play with: `player007`",
                            onPressed: () {
                              Navigator.pushNamed(context, "/confirm-match");

                              // the game page
                            }),
                      ],
                    );
                  }
                },
              )
            ],
          ),
        ));
  }
}
