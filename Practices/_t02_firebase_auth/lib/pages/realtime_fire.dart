import 'package:_t02_firebase_auth/constants/constants.dart';
import 'package:_t02_firebase_auth/constants/utils.dart';
import 'package:_t02_firebase_auth/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RealtimeFirePage extends StatefulWidget {
  const RealtimeFirePage({super.key});

  @override
  State<RealtimeFirePage> createState() => _RealtimeFirePageState();
}

class _RealtimeFirePageState extends State<RealtimeFirePage> {
  int starCount = -1;
  // baire thakai valo
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child('test');

  @override
  void initState() {
    super.initState();
    _dbRef.onValue.listen((event) {
      print("Got a new value $event");
      if (event.snapshot.exists) {
        updateStarCount((event.snapshot.value as Map)['starCount']);
        // print(event.snapshot.value.jsify());
      }
      print("Got something: ${event.snapshot.value.runtimeType}");

      // starCount =
      return;
    });
  }

  void updateStarCount(int count) {
    setState(() {
      starCount = count;
    });
  }

  @override
  void dispose() {
    // _dbRef.off();
    // print(_dbRef);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.createAppBar("Real-time Fire :3"),
      body: FutureBuilder(
        future: _firebaseApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Some error occuered");
          } else if (snapshot.hasData) {
            return Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Utils.wwContainer(
                    Text("starCount: $starCount"), (Colors.black12)),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Utils.wwContainer(
                      TextButton(
                        onPressed: () async {
                          await _dbRef.update({
                            'starCount': starCount + 1,
                          });
                        },
                        child: Text("count++"),
                      ),
                      Colors.white,
                    ),
                    Utils.wwContainer(
                      TextButton(
                        onPressed: () async {
                          await _dbRef.update({
                            'starCount': starCount - 1,
                          });
                        },
                        child: Text("count--"),
                      ),
                      Colors.white,
                    ),
                  ],
                ),
              ],
            );
          } else {
            return const Row(
              children: [
                Text("Loading..."),
                CircularProgressIndicator(),
              ],
            );
          }
        },
      ),
    );
  }
}

// Widget realtimeContent(dynamic realtimePageWidget) {
//   DatabaseReference starCountRef = FirebaseDatabase.instance.ref('/stars');

//   // void starPlusPlus(DatabaseReference starCountRef) async {
//   //   await starCountRef.update(
//   //       {"count": realtimePageWidget.starCount + 1, "notCount": "xxyy"});
//   // }

//   // void starMinusMinus(DatabaseReference starCountRef) async {
//   //   await starCountRef.update(
//   //       {"count": realtimePageWidget.starCount - 1, "notCount": "xxyy"});
//   // }

//   return Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [Text("${realtimePageWidget.starCount}")],
//     ),
//   );
// }
