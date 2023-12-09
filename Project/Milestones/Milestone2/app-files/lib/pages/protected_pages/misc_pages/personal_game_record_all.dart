import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/utils/Utils.dart';

class PersonalGameRecordAll extends StatefulWidget {
  const PersonalGameRecordAll({super.key});

  @override
  State<PersonalGameRecordAll> createState() => _PersonalGameRecordAllState();
}

class _PersonalGameRecordAllState extends State<PersonalGameRecordAll> {
  final List dummyData = [
    {"playerName": "player43", "result": false},
    {"playerName": "player34", "result": false},
    {"playerName": "player45", "result": true},
    {"playerName": "player75", "result": true},
    {"playerName": "player23", "result": true},
    {"playerName": "player43", "result": false},
    {"playerName": "player34", "result": false},
    {"playerName": "player45", "result": true},
    {"playerName": "player75", "result": true},
    {"playerName": "player23", "result": true},
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
            Text("total 489 records"),
            Text("showing 1-20"),
            Container(
              alignment: Alignment.center,
              child: Text(""),
            ),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    Text("Game Id"),
                    Text("Opponent"),
                    Text("Result"),
                  ],
                ),
                ...dummyData.map((e) {
                  return TableRow(children: [
                    Text("game_id"),
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
                  "Load more...",
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
