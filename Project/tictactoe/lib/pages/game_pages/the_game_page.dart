import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/utils/Utils.dart';

class TheGamePage extends StatefulWidget {
  const TheGamePage({super.key});

  @override
  State<TheGamePage> createState() => _TheGamePageState();
}

class _TheGamePageState extends State<TheGamePage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonProtectedAppbar(
            title: "The Game", context: context, user: user, leading: false),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(user?.displayName ?? "you"),
                  Text("vs"),
                  Text("some player"),
                ],
              ),
              // Grid

              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showCustomDialog(
                        context: context,
                        title: "Place ${index}",
                        description: "X|0 will be here.",
                        popText: "Ok",
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text("place ${index}"),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: 9,
              ),

              commonOutlineButton(
                  text: "end game",
                  onPressed: () {
                    Navigator.popAndPushNamed(
                        context, "/rematch-or-end-session");
                  })
            ],
          ),
        ));
  }
}
