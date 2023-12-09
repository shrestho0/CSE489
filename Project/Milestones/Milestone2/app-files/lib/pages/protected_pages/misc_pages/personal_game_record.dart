import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/utils/Utils.dart';

class PersonalGameRecord extends StatefulWidget {
  const PersonalGameRecord({super.key});

  @override
  State<PersonalGameRecord> createState() => _PersonalGameRecordState();
}

class _PersonalGameRecordState extends State<PersonalGameRecord> {
  final List dummyData = [
    {"playerName": "player43", "result": false},
    {"playerName": "player34", "result": false},
    {"playerName": "player45", "result": true},
    {"playerName": "player75", "result": true},
    {"playerName": "player23", "result": true},
  ];

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: commonProtectedAppbar(
          title: "Game Records", context: context, user: user),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // text with border
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(5.0),
              decoration:
                  textInsideBox(), //             <--- BoxDecoration here
              child: Text(
                "your position: 96",
                style: TextStyle(fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(""),
            ),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    Text("Opponent"),
                    Text("Result"),
                  ],
                ),
                ...dummyData.map((e) {
                  return TableRow(children: [
                    Text(e["playerName"]),
                    Text(e["result"] ? "Won" : "Lost"),
                  ]);
                }),
              ],
            ),

            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/personal-game-record-all");
              },
              child: Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(5.0),
                clipBehavior: Clip.antiAlias,
                decoration: textInsideBox(
                    radius: 10), //             <--- BoxDecoration here
                child: Text(
                  "view all records",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
