import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/pages/protected_pages/home_page.dart';
import 'package:tictactoe/utils/Constants.dart';
import 'package:tictactoe/utils/Utils.dart';

/// Post Game page er maybe dorkar ee nei, ekhanei logic diye show kora jabe, accordingly kaj kora jabe.
/// feels a bit comfortable now

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

  dynamic gameData;

  DatabaseReference? ref;

  void initRTConn() {
    ref =
        FirebaseDatabase.instance.ref("games").child(widget.gameId.toString());

    ref?.onValue.listen((DatabaseEvent event) {
      // check moves in the values
      //

      dynamic _gd = event.snapshot.value;
      // TODO: check all values are present
      // if not then return to home page

      if (_gd != null) {
        setState(() {
          gameData = _gd;
        });
      } else {
        // TODO: this works, don't it now.
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }

      print("LIVE GAME [[PRE-PROCCESSED]] :: ${event.snapshot.value}");
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

  _updateGameData() {
    gameData = gameData as Map<dynamic, dynamic>;

    FirebaseDatabase.instance
        .ref("games")
        .child(widget.gameId.toString())
        .set(gameData);
    // .child("moves")
    // .set(gameData["moves"]);
  }

  _saveGameDataToCollection() {
    // TODO: save game data to firestore collection
  }
  _setAwaitGameDelete() {
    // TODO: set await game delete
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
              // Container(
              //   decoration: (whoseTurn == 1)
              //       ? BoxDecoration(
              //           border:
              //               Border.all(color: AppConstants.primaryTextColor),
              //           borderRadius: BorderRadius.circular(10),
              //         )
              //       : null,
              //   child: Text(gameData["player2_name"]),
              // ),
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
                  if (whoseTurn == whoAmI) {
                    if (moveVal == 0) {
                      gameData['moves'][index] = whoAmI;
                      gameData['turn'] = (whoAmI == 1) ? 2 : 1;
                      _updateGameData();
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
                  else {
                    // Do Nothing
                    // Check if game
                    // showCustomDialog(
                    //   context: context,
                    //   title: "Place ${index}",
                    //   description: "Onno Player er turn",
                    //   popText: "Ok",
                    // );
                  }
                  ;
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

          commonOutlineButton(
              text: "end game",
              onPressed: () {
                Navigator.popAndPushNamed(context, "/rematch-or-end-session");
              }),
        ],
      ),
    ));
  }
}
