import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/pages/protected_pages/home_page.dart';
import 'package:tictactoe/services/game_services.dart';
import 'package:tictactoe/utils/Constants.dart';
import 'package:tictactoe/utils/Utils.dart';

/// Post Game page er maybe dorkar ee nei, ekhanei logic diye show kora jabe, accordingly kaj kora jabe.
/// feels a bit comfortable now

enum GameState { NOT_STARTED, STARTED, ENDED }

enum GameResult {
  // 0 Player None -> All 0 case OR incomplete game
  // 1 Player 1 wins
  // 2 Player 2 wins
  // 3 Draw
  INCOMPLETE,
  PLAYER_1_WINS,
  PLAYER_2_WINS,
  DRAW,
}

class TheGamePage extends StatefulWidget {
  final String gameId;
  final int sessionGameNumber;
  const TheGamePage({
    super.key,
    required this.gameId,
    required this.sessionGameNumber,
  });

  @override
  State<TheGamePage> createState() => _TheGamePageState();
}

class _TheGamePageState extends State<TheGamePage> {
  User? user = FirebaseAuth.instance.currentUser;
  GameState gameState = GameState.NOT_STARTED;
  GameResult gameResult = GameResult.INCOMPLETE;
  dynamic gameData;

  DatabaseReference? ref;

  void initRTConn() {
    ref =
        FirebaseDatabase.instance.ref("games").child(widget.gameId.toString());

    gameState = GameState.STARTED;

    ref?.onValue.listen((DatabaseEvent event) {
      // check moves in the values
      //

      dynamic _gd = event.snapshot.value;
      // TODO: check all values are present
      // if not then return to home page

      if (_gd != null) {
        if (_gd["winner"] != null) {
          setState(() {
            gameState = GameState.ENDED;
          });
        }
        setState(() {
          gameData = _gd;
        });
      } else {
        // TODO: this works, don't it now.
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }

      // print("LIVE GAME [[PRE-PROCCESSED]] :: ${event.snapshot.value}");
    });

    // check and return later if game does not exists
  }

  // We

  // State Mods
  @override
  void initState() {
    // gameData["awaitClosing"] = false;
    super.initState();
    initRTConn();
  }

  @override
  void dispose() {
    // TODO: Save the game data before deleting
    // Deletes the current game data

    ref?.remove();
    super.dispose();
  }

  _checkAndUpdateGameData() {
    gameData = gameData as Map<dynamic, dynamic>;

    // Check game
    // int gameStatus = _checkGame(gameData["moves"].toList());
    // print("LIVE GAME [[GAME_STATUS]] :: $gameStatus");

    print("MOVES CHECK HOBE");
    // List<int> moves = gameData["moves"];
    gameResult = _checkGame();
    if (gameResult == GameResult.INCOMPLETE) {
      _syncDataWithRT();
      return;
    } else {
      if (gameResult == GameResult.PLAYER_1_WINS) {
        gameData["playing"] = false;
        gameData["winner"] = 1;
      } else if (gameResult == GameResult.PLAYER_2_WINS) {
        gameData["playing"] = false;
        gameData["winner"] = 2;
      } else if (gameResult == GameResult.DRAW) {
        gameData["playing"] = false;
        gameData["winner"] = 0;
      }
      _syncDataWithRT();
      // setState(() {
      //   gameState = GameState.ENDED;
      // });
    }

    print("MOVES CHECK HOYESE");

    // .child("moves")
    // .set(gameData["moves"]);
  }

  void _syncDataWithRT() {
    FirebaseDatabase.instance
        .ref("games")
        .child(widget.gameId.toString())
        .set(gameData);
  }

  _saveGameDataToCollection() {
    // TODO: save game data to firestore collection
  }
  _setAwaitGameDelete() {
    // TODO: set await game delete
  }

  GameResult _checkGame() {
    /// 0 Player None -> All 0 case OR incomplete game
    // min 5 moves needed to win, >4 zeros -> 0
    int count_0 = 0;
    for (int i = 0; i < gameData["moves"].length; i++) {
      if (gameData["moves"][i] == 0) {
        count_0++;
      }
    }

    // Don't care about this now
    if (count_0 > 4) {
      return GameResult.INCOMPLETE;
    }

    bool player1Wins = _checkBoardForPlayer(1);
    bool player2Wins = _checkBoardForPlayer(2);
    if (player1Wins) {
      return GameResult.PLAYER_1_WINS;
    } else if (player2Wins) {
      return GameResult.PLAYER_2_WINS;
    }

    if (count_0 == 0) {
      return GameResult.DRAW;
    }

    /// 1 Player 1 wins
    /// 2 Player 2 wins
    /// 3 Draw

    return GameResult.DRAW;
  }

  @override
  Widget build(BuildContext context) {
    print("LIVE GAME [[DATA]] :: $gameData ${gameData.runtimeType}");
    if (gameData == null) {
      return const Scaffold(
        body: Center(
          // TODO: there could be a gif or something like that
          child: CircularProgressIndicator(),
        ),
      );
    }

    gameData = gameData as Map<dynamic, dynamic>;

    int whoAmI = (gameData["player1_id"] == user!.uid)
        ? 1
        : (gameData["player2_id"] == user!.uid)
            ? 2
            : 0;

    int whoseTurn = gameData["turn"];

    // thisIsMyTurn = gameData["turn"] == 1 ? true : false;

    print(
        "LIVE GAME [[MOVES]] ${gameData['moves']} ${gameData['moves'].runtimeType}");

    return Scaffold(
        // appBar: commonProtectedAppbar(
        //     title: "The Game", context: context, user: user, leading: false),
        body: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100),
          Text("kichu ekta hobe"),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: (whoAmI == whoseTurn)
                    ? BoxDecoration(
                        border:
                            Border.all(color: AppConstants.primaryTextColor),
                        borderRadius: BorderRadius.circular(10),
                      )
                    : null,
                child: Text(user?.uid == gameData["player2_id"]
                    ? gameData["player2_name"]
                    : gameData["player1_name"]),
              ),
              const Text("vs"),
              Container(
                decoration: (whoAmI != whoseTurn)
                    ? BoxDecoration(
                        border:
                            Border.all(color: AppConstants.primaryTextColor),
                        borderRadius: BorderRadius.circular(10),
                      )
                    : null,
                child: Text(user?.uid != gameData["player2_id"]
                    ? gameData["player2_name"]
                    : gameData["player1_name"]),
              ),
            ],
          ),
          // Grid

          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
            itemBuilder: (context, index) {
              int moveVal = gameData['moves'][index];
              return GestureDetector(
                onTap: () {
                  // ignore all wrong input for each user
                  if (gameState == GameState.ENDED) {
                    return;
                  }
                  if (whoseTurn == whoAmI) {
                    if (moveVal == 0) {
                      gameData['moves'][index] = whoAmI;
                      gameData['turn'] = (whoAmI == 1) ? 2 : 1;

                      _checkAndUpdateGameData();
                      // parbe
                    } else {
                      // parbe na
                      showCustomDialog(
                        context: context,
                        title: "Dite parba na",
                        // description: "X|0 will be here.",
                        popText: "Ok",
                      );
                    }
                  }
                  // Onno Player er turn
                  else {}
                },
                child: Container(
                  // padding: const EdgeInsets.all(10.0),
                  alignment: Alignment.center,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppConstants.primaryMainColor,
                      width: 2,
                    ),
                  ),
                  child: moveVal == 0
                      ? null
                      : Icon(
                          moveVal == 1 ? Icons.circle_outlined : Icons.close,
                          size: 35,
                        ),
                ),
              );
            },
            itemCount: 9,
          ),

          Text(gameState.toString()),

          commonOutlineButton(
              text: "end game",
              onPressed: () {
                Navigator.popAndPushNamed(context, "/rematch-or-end-session");
              }),
        ],
      ),
    ));
  }

  _checkBoardForPlayer(int moveVal) {
    dynamic moves = gameData["moves"];
    // 0 1 2
    // 3 4 5
    // 6 7 8

    // 0 1 2
    if (moves[0] == moveVal && moves[1] == moveVal && moves[2] == moveVal) {
      return true;
    }
    // 3 4 5
    if (moves[3] == moveVal && moves[4] == moveVal && moves[5] == moveVal) {
      return true;
    }
    // 6 7 8
    if (moves[6] == moveVal && moves[7] == moveVal && moves[8] == moveVal) {
      return true;
    }

    // 0 3 6
    if (moves[0] == moveVal && moves[3] == moveVal && moves[6] == moveVal) {
      return true;
    }
    // 1 4 7
    if (moves[1] == moveVal && moves[4] == moveVal && moves[7] == moveVal) {
      return true;
    }
    // 2 5 8
    if (moves[2] == moveVal && moves[5] == moveVal && moves[8] == moveVal) {
      return true;
    }

    // 0 4 8
    if (moves[0] == moveVal && moves[4] == moveVal && moves[8] == moveVal) {
      return true;
    }
    // 2 4 6
    if (moves[2] == moveVal && moves[4] == moveVal && moves[6] == moveVal) {
      return true;
    }

    return false;
  }
}
