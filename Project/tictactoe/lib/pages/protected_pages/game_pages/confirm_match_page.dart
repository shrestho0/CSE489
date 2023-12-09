import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/pages/protected_pages/game_pages/the_game_page.dart';
import 'package:tictactoe/utils/Types.dart';
import 'package:tictactoe/utils/Utils.dart';

class ConfirmMatchPage extends StatefulWidget {
  final GameType gameType;
  final String? gameId;
  final int who_joined;
  final String name_who;
  final String uid_who;

  const ConfirmMatchPage({
    super.key,
    this.gameType = GameType.ONLINE,
    this.gameId,
    required this.who_joined,
    required this.name_who,
    required this.uid_who,
  });

  @override
  State<ConfirmMatchPage> createState() => _ConfirmMatchPageState();
}

class _ConfirmMatchPageState extends State<ConfirmMatchPage> {
  User? user = FirebaseAuth.instance.currentUser;

  final inviteEditingController = TextEditingController();

  void createRTGame(String gameId) {
    var _random = new Random();
    // game data about game

    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("games").child(gameId);

    Map<String, Object> gameData = {
      "turn": _random.nextInt(2) + 1,
      "moves": [0, 0, 0, 0, 0, 0, 0, 0, 0],
      "playing": false,
    };
    if (widget.who_joined == 1) {
      gameData["player1_joined"] = true;
      gameData["player1_name"] = widget.name_who;
      gameData["player1_id"] = widget.uid_who;
    } else if (widget.who_joined == 2) {
      gameData["player2_joined"] = true;
      gameData["player2_name"] = widget.name_who;
      gameData["player2_id"] = widget.uid_who;
    }

    // "player1_joined": widget.who_joined == 1 ? true : false,

    databaseReference.once().then((event) {
      print(gameId);
      print(event.snapshot.value);
      if (event.snapshot.value == null) {
        // create game
        databaseReference.set(gameData);
      } else {
        gameData["playing"] = true;
        databaseReference.update(gameData);
      }
    });
  }

  void manageRealtimeSubscription() {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref("games")
        .child(widget.gameId.toString())
        .child("playing");
    ref.onValue.listen((dynamic event) {
      // print(
      //     "Realtime event: ${event.snapshot.value} ${event.snapshot.value.runtimeType} ");
      if (event.snapshot.exists) {
        print(
            "${event.snapshot.value} :: ${event.snapshot.value.runtimeType} :: :: ${event.snapshot}");
        // check if value has the key
        if (event.snapshot.value == true) {
          // game started
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              // TheGamePage takes game id, user1 displayname, user2 di

              return TheGamePage(
                  // what we can do is,
                  // on each round end, we can take the game data from here and save in firestore as GameData
                  // on re-match, we can create new game from current game data and save this one to firestore as GameData
                  // we can store the session number in the firestore sessions collection too. But, that can be done later
                  // need to finish this one first.
                  // for now, we will send the sessionGameNumber to next next pages until the new game.
                  // finally destory the sessionGameNumber, for now of course
                  gameId: widget.gameId.toString(),
                  sessionGameNumber: 1);
            },
          ));
        } else {
          // wait
        }
        // do nothjing
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    manageRealtimeSubscription();

    createRTGame(widget.gameId!);

    // createRTGame(widget.gameId!);

    // both joined, start the game

    // Create record in the database

    // Generate game data and start game

    print("creating new game on realtime");
    print(widget.gameId);
    print(widget.gameType);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // ref.clea;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonProtectedAppbar(
            title: "Ready to play!",
            context: context,
            user: user,
            leading: false),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              appHomeButton(
                  title: "temp create game",
                  icon: Icon(Icons.abc),
                  onPressed: () => createRTGame(widget.gameId!)),
              Text(widget.gameType.toString()),
              Text(widget.gameId.toString()),
              SizedBox(height: 20),
              const Text("Match Found!!"),
              const Text("Will Be Redirected!"),
            ],
          ),
        ));
  }
}
