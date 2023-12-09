import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/utils/Utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    print("${user}");
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            authHeaderRow(context, user),

            commonOutlineButton(
              text: "Find Players Online",
              onPressed: () {
                Navigator.pushNamed(context, "/find-players-online");
              },
            ),

            commonOutlineButton(
              text: "Join with invitation code",
              onPressed: () {
                Navigator.pushNamed(context, "/join-with-invitation-code");
              },
            ),

            commonOutlineButton(
                text: "Invite someone to play",
                onPressed: () {
                  Navigator.pushNamed(context, "/invite-someone-to-play");
                }),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              children: [
                commonOutlineButton(
                    text: "Leaderboard",
                    onPressed: () {
                      Navigator.pushNamed(context, "/leaderboard");
                    }),
                commonOutlineButton(
                    text: "Game Record",
                    onPressed: () {
                      Navigator.pushNamed(context, "/personal-game-record");
                    }),
              ],
            )

            // Container(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       OutlinedButton(
            //         child: Text("Leaderboard"),
            //         onPressed: () {
            //           Navigator.pushNamed(context, "/leaderboard");
            //         },
            //         style: OutlinedButton.styleFrom(
            //           backgroundColor: Colors.black87,
            //           foregroundColor: Colors.white,
            //           shape: const RoundedRectangleBorder(
            //             borderRadius: BorderRadius.all(
            //               Radius.circular(5),
            //             ),
            //           ),
            //         ),
            //       ),
            //       OutlinedButton(
            //         child: Text(
            //           "Game Record",
            //         ),
            //         onPressed: () {
            //           Navigator.pushNamed(context, "/personal-game-record");
            //         },
            //         style: OutlinedButton.styleFrom(
            //           backgroundColor: Colors.black87,
            //           foregroundColor: Colors.white,
            //           shape: const RoundedRectangleBorder(
            //             borderRadius: BorderRadius.all(
            //               Radius.circular(5),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            /// TODO: Old Stuff
          ],
        ),
      ),
    );
  }
}
