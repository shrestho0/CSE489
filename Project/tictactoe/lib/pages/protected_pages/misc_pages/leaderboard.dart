import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/utils/Utils.dart';

import 'package:firebase_database/firebase_database.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  void manageRealtimeSubscription() {
    DatabaseReference ref = FirebaseDatabase.instance.ref("games");
    ref.onValue.listen((event) {
      print("Realtime event: ${event.snapshot.value}");
    });
  }

  void addSomething() {
    DatabaseReference ref = FirebaseDatabase.instance.ref("games");
    ref.set({
      "game_id": randomString(2),
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    manageRealtimeSubscription();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: commonProtectedAppbar(
          title: "Leaderboard", context: context, user: user),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              appHomeButton(
                  title: "add random",
                  icon: Icon(Icons.abc),
                  onPressed: addSomething),
              // text with border
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(5.0),
                decoration:
                    textInsideBox(), //             <--- BoxDecoration here
                child: Text(
                  "your position: 96",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              Text("top players"),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Table(
                  // columnWidths: const <int, TableColumnWidth>{
                  //   0: IntrinsicColumnWidth(),
                  //   1: FlexColumnWidth(),
                  //   2: FixedColumnWidth(64),
                  // },

                  // border: TableBorder.all(),
                  children: [
                    TableRow(children: [
                      Text("Rank"),
                      Text("Name"),
                      Text("Total wins"),
                    ]),
                    TableRow(children: [
                      Text("1"),
                      Text("John Doe"),
                      Text("100"),
                    ]),
                    TableRow(children: [
                      Text("2"),
                      Text("John Doe"),
                      Text("100"),
                    ]),
                    TableRow(children: [
                      Text("3"),
                      Text("John Doe"),
                      Text("100"),
                    ]),
                    TableRow(children: [
                      Text("4"),
                      Text("John Doe"),
                      Text("100"),
                    ]),
                    TableRow(children: [
                      Text("5"),
                      Text("John Doe"),
                      Text("100"),
                    ]),
                    TableRow(children: [
                      Text("6"),
                      Text("John Doe"),
                      Text("100"),
                    ]),
                    TableRow(children: [
                      Text("7"),
                      Text("John Doe"),
                      Text("100"),
                    ]),
                    TableRow(children: [
                      Text("8"),
                      Text("John Doe"),
                      Text("100"),
                    ]),
                    TableRow(children: [
                      Text("9"),
                      Text("John Doe"),
                      Text("100"),
                    ]),
                    TableRow(children: [
                      Text("10"),
                      Text("John Doe"),
                      Text("100"),
                    ]),
                  ],
                ),
              ),

              // TODO: Check :: Seems unecessary
              // Container(
              //   margin: const EdgeInsets.all(10.0),
              //   padding: const EdgeInsets.all(5.0),
              //   clipBehavior: Clip.antiAlias,
              //   decoration: textInsideBox(
              //       radius: 10), //             <--- BoxDecoration here
              //   child: Text(
              //     "view more records",
              //     style: TextStyle(fontSize: 15.0),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
