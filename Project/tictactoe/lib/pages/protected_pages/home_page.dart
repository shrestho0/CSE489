import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/pages/auth_pages/auth_handler_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    print("${user}");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text("${user?.displayName}"),
            // Text("${user?.email}"),
            Text(user.toString()),

            // Text("hello fucking world!"),
            const OutlinedButton(onPressed: signOut, child: Text("sign out")),
            ClipOval(
              child: user?.photoURL != null
                  ? Image.network(
                      user!.photoURL.toString(),
                      height: 50,
                      width: 50,
                    )
                  : const Icon(
                      Icons.person,
                      color: Colors.redAccent,
                    ),
            )
            // CircleAvatar(
            //   radius: Size.fromRadius(50),
            //   child: user?.photoURL != null
            //       ? Image.network(
            //           userPhoto,
            //           height: 50,
            //           width: 50,
            //         )
            //       : const Icon(Icons.person),
            // )
          ],
        ),
      ),
    );
  }
}
