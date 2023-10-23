import 'package:_t02_firebase_auth/constants/constants.dart';
import 'package:_t02_firebase_auth/constants/utils.dart';
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
  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('/stars');

  late dynamic databaseSub;

  @override
  void initState() {
    super.initState();
    starCountRef.onValue.listen((DatabaseEvent event) {
      try {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        print("Realtime data updated $data ${data.runtimeType}");

        updateStarCount(data['count'] as int);
      } catch (err) {
        print(err);
      }
    });
  }

  void updateStarCount(int count) {
    print("Updating value to $count");
    setState(() {
      starCount = count;
    });
  }

  void starPlusPlus() async {
    await starCountRef.update({"count": starCount + 1, "notCount": "xxyy"});
  }

  void starMinusMinus() async {
    await starCountRef.update({"count": starCount - 1, "notCount": "xxyy"});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.createAppBar("Real-time Fire :3"),
      body: Column(
        children: [
          Text("test01"),
          Utils.wwContainer(
              Text(
                "Start Count: $starCount",
                style: TextStyle(fontSize: 20),
              ),
              Colors.black45),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                    onPressed: starMinusMinus,
                    child: const Text(
                      "start--",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                    onPressed: starPlusPlus,
                    child: const Text(
                      "start++",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
