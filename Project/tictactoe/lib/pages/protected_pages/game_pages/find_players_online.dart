import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/utils/Constants.dart';
import 'package:tictactoe/utils/Utils.dart';

class FindPlayersOnline extends StatefulWidget {
  const FindPlayersOnline({super.key});

  @override
  State<FindPlayersOnline> createState() => _FindPlayersOnlineState();
}

class _FindPlayersOnlineState extends State<FindPlayersOnline> {
  User? user = FirebaseAuth.instance.currentUser;
  // var counterStream =
  //     Stream<int>.periodic(const Duration(seconds: 1), (x) => x).take(3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.red,
        // padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        padding: const EdgeInsets.only(
          top: 100,
          bottom: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Image(
                  image: AssetImage('assets/ic_launcher.png'),
                  height: 50,
                  width: 50,
                ),
                const Text(
                  "tictactoe",
                  style: TextStyle(
                    color: AppConstants.primaryTextColor,
                    fontSize: 20.0,
                    fontFamily: "Kongtext",
                  ),
                ),
                ClipOval(
                  child: user?.photoURL != null
                      ? Image.network(
                          user!.photoURL.toString(),
                          height: 50,
                          width: 50,
                        )
                      : const CircleAvatar(
                          backgroundColor: Colors.black87,
                          child: Icon(
                            Icons.person,
                            color: Colors.white70,
                          ),
                        ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                "welcome, ${user?.displayName}",
                style: const TextStyle(
                  color: AppConstants.primaryTextColor,
                  // fontSize: 20.0,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.search),
                const Text("finding online players..."),
                const Text("(wait for 3 seconds)"),
                const Text("...."),
                // StreamBuilder(
                //   stream: counterStream,
                //   builder: (context, snapshot) {
                //     if (snapshot.data != 2) {
                //       return CircularProgressIndicator(
                //         color: Colors.black87,
                //       );
                //     } else {
                // return
                Column(
                  children: [
                    const Text("Player found"),
                    commonOutlineButton(
                        text: "play with: `player007`",
                        onPressed: () {
                          Navigator.pushNamed(context, "/confirm-match");

                          // the game page
                        }),
                    commonOutlineButton(
                        text: "cancel",
                        onPressed: () {
                          Navigator.pop(context);
                          // the game page
                        }),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
