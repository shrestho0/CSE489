import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  dynamic winningMoves;
  dynamic winningPlayer;

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
        if (_gd["winner"] == 1 || _gd["winner"] == 2 || _gd["winner"] == 3) {
          setState(() {
            winningMoves = _gd["winningMoves"];
            winningPlayer = _gd["winner"];

            /// TODO: forgot what the heck these were
            /// Check and fix later
            // print("Winning Moves :: $winningMoves");
            // if (_gd["winner"] == 1) {
            //   winnerData = {
            //     "winner_name": _gd["player1_name"],
            //     "winner_id": _gd["player1_id"],
            //   };
            // } else if (_gd["winner"] == 2) {
            //   winnerData = {
            //     "winner_name": _gd["player2_name"],
            //     "winner_id": _gd["player2_id"],
            //   };
            // } else {

            //   winnerData = {
            //     "winner_name": "Draw",
            //     "winner_id": "Draw",
            //   };
            // }
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
  void dispose() async {
    // Better code if whatever
    // Future.delayed(Duration.zero, () async {
    //   await doingSomething().then((value) => print(value));
    // });
    // TODO: Save the game data before deleting
    // Deletes the current game data
    print("[[ DEBUG ]]: Game Disposed");

    //// ALL OF THESE WILL BE HANDLED IN GAME SERVICES
    // Update the game from Game Collection with game id
    /// This deletes the game data from realtime
    // context.read<GameServices>().deleteRTGame(widget.gameId, ref);
    // context.read<GameServices>().quitGame(context, widget.gameId, ref);

    // TODO: do this later
    // ei hishab pore korte hobe
    /// jodi user back kore then, send them to home
    /// jodi user app off kore dey, pera nei.
    /// amader cloud function orphaned data gulo check kore delete kore debe.
    super.dispose();
  }

  _checkAndUpdateGameData() {
    gameData = gameData as Map<dynamic, dynamic>;

    // Check game
    // int gameStatus = _checkGame(gameData["moves"].toList());
    // print("LIVE GAME [[GAME_STATUS]] :: $gameStatus");

    // print("MOVES CHECK HOBE");
    // List<int> moves = gameData["moves"];
    // var (gameResult, winningMovesX) = _checkGame(gameData);

    var (gameResult, winningMovesX) =
        context.read<GameServices>().checkGame(gameData);

    if (gameResult == GameResult.INCOMPLETE) {
      context
          .read<GameServices>()
          .updateDataWithRT(widget.gameId.toString(), gameData);
      return;
    }
    {
      if (gameResult == GameResult.PLAYER_1_WINS) {
        gameData["playing"] = false;
        gameData["winner"] = 1;
      } else if (gameResult == GameResult.PLAYER_2_WINS) {
        gameData["playing"] = false;
        gameData["winner"] = 2;
      } else if (gameResult == GameResult.DRAW) {
        gameData["playing"] = false;
        gameData["winner"] = 3;
      }
      gameData["winningMoves"] = winningMovesX;
      // _updateDataWithRT();

      // Sync the latest data with Realtime Database
      context
          .read<GameServices>()
          .updateDataWithRT(widget.gameId.toString(), gameData);
      // setState(() {
      //   gameState = GameState.ENDED;
      // });
    }

    // print("MOVES CHECK HOYESE");

    // .child("moves")
    // .set(gameData["moves"]);
  }

  // void _updateDataWithRT() {
  //   FirebaseDatabase.instance
  //       .ref("games")
  //       .child(widget.gameId.toString())
  //       .set(gameData);
  // }

  /// TODO: Handle will pop later

  // Future<bool> _onWillPop() async {
  //   if(gameState == GameState.ENDED) {
  //     return true;
  //   }
  //   else {
  //     (await  showDialog(context: context, builder: (context) => AlertDialog(
  //       title: const Text("Are you sure?"),
  //       content: const Text("Do you want to exit the game?"),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(false),
  //           child: const Text("No"),    // context.read<GameServices>().deleteRTGame(widget.gameId, ref);

  //         ),
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(true),
  //           child: const Text("Yes"),
  //         ),
  //       ],
  //     ))) ?? false;
  //   // return (await showDialog(
  //   //   context: context,
  //   // ));
  //   //   context: context,
  //   //   builder: (context) new AlertDialog(
  //   //     title: new Text('Are you sure?'),
  //   //     content: new Text('Do you want to exit an App'),
  //   //     actions: <Widget>[
  //   //       TextButton(
  //   //         onPressed: () => Navigator.of(context).pop(false),
  //   //         child: new Text('No'),
  //   //       ),
  //   //       TextButton(
  //   //         onPressed: () => Navigator.of(context).pop(true),
  //   //         child: new Text('Yes'),
  //   //       ),
  //   //     ],
  //   //   ),
  //   // )) ??
  //   // return false

  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    print("LIVE GAME [[DATA]] :: $gameData ${gameData.runtimeType}");

    // Shows if game data is null
    // But, this is subscribed to rt db
    if (gameData == null) {
      return const Scaffold(
        body: Center(
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
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Text("The Game"),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  // Game state ENDED na hole border dekhabe, else na.
                  decoration:
                      (whoAmI == whoseTurn && gameState != GameState.ENDED)
                          ? AppConstants.gamePlayingActiveDecoraton
                          : AppConstants.gamePlayingInactiveDecoraton,
                  child: Text(
                    user?.uid == gameData["player2_id"]
                        ? gameData["player2_name"]
                        : gameData["player1_name"],
                    style:
                        ((gameData["winner"] == 1 || gameData["winner"] == 2) &&
                                gameData["winner"] == whoAmI)
                            ? AppConstants.gameEndWinnerTextStyle
                            : (gameData["winner"] == 3)
                                ? AppConstants.gameEndDrawTextStyle
                                : AppConstants.gameEndLoserTextStyle,
                  ),
                ),
                const Text("vs"),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration:
                      (whoAmI != whoseTurn && gameState != GameState.ENDED)
                          ? AppConstants.gamePlayingActiveDecoraton
                          : AppConstants.gamePlayingInactiveDecoraton,
                  child: Text(
                    user?.uid != gameData["player2_id"]
                        ? gameData["player2_name"]
                        : gameData["player1_name"],
                    style:
                        ((gameData["winner"] == 1 || gameData["winner"] == 2) &&
                                gameData["winner"] != whoAmI)
                            ? AppConstants.gameEndWinnerTextStyle
                            : (gameData["winner"] == 3)
                                ? AppConstants.gameEndDrawTextStyle
                                : AppConstants.gameEndLoserTextStyle,
                  ),
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
                    // ignore all wrong inputs
                    if (gameState == GameState.ENDED) {
                      context.read<GameServices>().showGameErrorMsg(
                            text: "Game ended",
                            popText: "Close",
                            context: context,
                            // TODO: Not implemented
                            // callback: () {
                            //   print("Game Ended mf");
                            // },
                          );
                    }
                    if (whoseTurn == whoAmI) {
                      if (moveVal == 0) {
                        gameData['moves'][index] = whoAmI;
                        gameData['turn'] = (whoAmI == 1) ? 2 : 1;

                        _checkAndUpdateGameData();
                        // parbe
                      } else {
                        // parbe na
                        context.read<GameServices>().showGameErrorMsg(
                              text: "Not allowed",
                              popText: "Close",
                              context: context,
                              callback: () {
                                print("Game Ended mf");
                              },
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
                            color: winningMoves != null
                                ? winningMoves.contains(index)
                                    ? Colors.greenAccent
                                    : AppConstants.primaryTextColor
                                : AppConstants.primaryTextColor,
                          ),
                  ),
                );
              },
              itemCount: 9,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                (gameState == GameState.ENDED && winningPlayer != null)
                    ? (winningPlayer == 1)
                        ? gameData["player1_name"] + " won"
                        : (winningPlayer == 2)
                            ? gameData["player2_name"] + " won"
                            : (winningPlayer == 3)
                                ? "Draw"
                                : ""
                    : " ",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            gameState == GameState.ENDED
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      appHomeButton(
                        title: "re-match",
                        icon: const Icon(Icons.repeat),
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.all(5),
                        onPressed: () => context
                            .read<GameServices>()
                            .rematchGame(context, gameData),
                      ),
                      appHomeButton(
                        title: "quit game",
                        icon: const Icon(Icons.cancel),
                        onPressed: () =>
                            // ref pathano better,
                            // extra connection pool er dorkar nei
                            context
                                .read<GameServices>()
                                .quitGame(context, widget.gameId, ref),
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.all(5),
                      )
                    ],
                  )
                : Container(),
            // appHomeButton(title: "re-match", icon: Icon(Icons.read_more)),
            // commonOutlineButton(
            //     text: "end game",
            //     onPressed: () {
            //       Navigator.popAndPushNamed(context, "/rematch-or-end-session");
            //     }),
          ],
        ),
      ),
    );
  }
}
