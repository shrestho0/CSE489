import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/pages/protected_pages/game_pages/the_game_page.dart';
import 'package:tictactoe/utils/Constants.dart';

class GameServices extends ChangeNotifier {
  bool _loading = false;
  get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void createRTGame({
    required String gameId,
    required int who_joined,
    required String name_who,
    required String uid_who,
  }) {
    // game data about game

    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("games").child(gameId);

    Map<String, Object> newGameData = {
      "turn": Random().nextInt(2) + 1,
      "moves": [0, 0, 0, 0, 0, 0, 0, 0, 0],
      "playing": false,
    };

    if (who_joined == 1) {
      newGameData["player1_joined"] = true;
      newGameData["player1_name"] = name_who;
      newGameData["player1_id"] = uid_who;
    } else if (who_joined == 2) {
      newGameData["player2_joined"] = true;
      newGameData["player2_name"] = name_who;
      newGameData["player2_id"] = uid_who;
    }

    databaseReference.once().then((event) {
      print("[[ DEBUG:  createRTGame ]] Creating real time game with $gameId");

      print(
          "[[ DEBUG:  createRTGame ]] Creating real time game with ${event.snapshot.value}");

      if (event.snapshot.value == null) {
        // create game
        databaseReference.set(newGameData);
      } else {
        // update game
        // both side joined
        newGameData["playing"] = true;
        databaseReference.update(newGameData);
      }
    });
  }

  Future<void> _deleteRTGameAndAddToGameHistory(
    String gameId,
    DatabaseReference? ref,
  ) async {
    /// Check if this really needs to be async or not
    ref?.once().then((event) {
      if (event.snapshot.value != null) {
        dynamic gameData = event.snapshot.value;

        _moveRTGameToGameHistory(gameId, gameData);

        // TODO: remove game data from TempGame too with id gameId

        ref.remove();
      } else {
        print("DEBUG: Game data is null. Seems already deleted");
      }
    });
  }

  void _moveRTGameToGameHistory(gameId, gameData) async {
    // GameHistory
    gameData["server_end_time"] = FieldValue.serverTimestamp();
    print("DEBUG: Uploading to GameHistory Game data: $gameData");
    var db = FirebaseFirestore.instance;
    db.collection("GameHistory").doc(gameId).set({
      "player1_id": gameData["player1_id"],
      "player2_id": gameData["player2_id"],
      "winner": gameData["winner"],
      "server_end_time": gameData["server_end_time"],
    });
  }

  /// These methods don't use any state of this class, just using to keep game services organized
  /// Make these static
  void quitGame(context, gameId, ref) async {
    print("DEBUG: Quitting Game");
    //  context.read<GameServices>().deleteRTGameAndAddToGameHistory(widget.gameId, ref);
    await _deleteRTGameAndAddToGameHistory(gameId, ref);

    // Navigator.popUntil(context, (route) => false);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const HomePage()),
    // );
    AppConstants.backToHome(context);
  }

  void rematchGame(
    context,
    gameData,
  ) {
    // User game data should be retrieved from this service
    print("DEBUG: Re-matching Game");
  }

  void updateDataWithRT(gameId, gameData) {
    FirebaseDatabase.instance.ref("games").child(gameId).set(gameData);
  }

  (GameResult, List<int>) checkGame(gameData) {
    /// 0 Player None -> All 0 case OR incomplete game
    // min 5 moves needed to win, >4 zeros -> 0
    int emptyFields = 0;
    for (int i = 0; i < gameData["moves"].length; i++) {
      if (gameData["moves"][i] == 0) {
        emptyFields++;
      }
    }
    if (emptyFields > 4) {
      // Er age check korar dorkar nei
      return (GameResult.INCOMPLETE, [-1, -1, -1]);
    }

    var (player1Wins, player1WinningMoves) =
        _checkBoardForPlayer(gameData["moves"], 1);
    var (player2Wins, player2WinningMoves) =
        _checkBoardForPlayer(gameData["moves"], 2);

    if (player1Wins) {
      return (GameResult.PLAYER_1_WINS, player1WinningMoves);
    } else if (player2Wins) {
      return (GameResult.PLAYER_2_WINS, player2WinningMoves);
    }

    if (emptyFields == 0) {
      // No empty fields and no player won yet
      return (GameResult.DRAW, [-1, -1, -1]);
    }

    return (GameResult.INCOMPLETE, [-1, -1, -1]);
  }

  (bool, List<int>) _checkBoardForPlayer(dynamic moves, int moveVal) {
    // dynamic moves = gameData["moves"];
    // 0 1 2
    // 3 4 5
    // 6 7 8

    // 0 1 2
    if (moves[0] == moveVal && moves[1] == moveVal && moves[2] == moveVal) {
      return (true, [0, 1, 2]);
    }
    // 3 4 5
    if (moves[3] == moveVal && moves[4] == moveVal && moves[5] == moveVal) {
      return (true, [3, 4, 5]);
    }
    // 6 7 8
    if (moves[6] == moveVal && moves[7] == moveVal && moves[8] == moveVal) {
      return (true, [6, 7, 8]);
    }

    // 0 3 6
    if (moves[0] == moveVal && moves[3] == moveVal && moves[6] == moveVal) {
      return (true, [0, 3, 6]);
    }
    // 1 4 7
    if (moves[1] == moveVal && moves[4] == moveVal && moves[7] == moveVal) {
      return (true, [1, 4, 7]);
    }
    // 2 5 8
    if (moves[2] == moveVal && moves[5] == moveVal && moves[8] == moveVal) {
      return (true, [2, 5, 8]);
    }

    // 0 4 8
    if (moves[0] == moveVal && moves[4] == moveVal && moves[8] == moveVal) {
      return (true, [0, 4, 8]);
    }
    // 2 4 6
    if (moves[2] == moveVal && moves[4] == moveVal && moves[6] == moveVal) {
      return (true, [2, 4, 6]);
    }

    return (false, [-1, -1, -1]);
  }

  void showGameErrorMsg({context, text, popText, String desc = "", callback}) {
    final snackBar = SnackBar(
      content: Text(text),
      // action: SnackBarAction(
      //   label: popText,
      //   onPressed: () {
      //     if (callback != null) {
      //       callback();
      //     }
      //     Navigator.pop(context);
      //   },
      // ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
