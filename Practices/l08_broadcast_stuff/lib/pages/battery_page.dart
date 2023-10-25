import 'dart:async';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:l08_broadcast_stuff/constants.dart';
// import 'package:battery_info/model/android_battery_info.dart';

class BatteryPercentagePage extends StatefulWidget {
  const BatteryPercentagePage({super.key, required this.title});
  final String title;

  @override
  State<BatteryPercentagePage> createState() => _BatteryPercentagePageState();
}

class _BatteryPercentagePageState extends State<BatteryPercentagePage> {
  // late BatteryState _batteryState;

  int? guessPct;
  final userInputController = TextEditingController();
  bool showErrorMsg = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.customAppBar(widget.title),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                // child: Text("${widget.title}"),
                child: Column(
                  children: [
                    // Container(
                    //   child: Text("DEBUG: Battery Pct: $batteryPct"),
                    // ),
                    TextField(
                      controller: userInputController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ], // Only numbers can be entered
                      // autofocus: true,
                      // maxLength: 3,
                      style: const TextStyle(
                        // color: Colors.red,
                        fontSize: 18,
                      ),
                      onChanged: (value) {
                        if (showErrorMsg) {
                          setState(() {
                            showErrorMsg = false;
                          });
                        }
                      },
                      // style: ,
                      decoration: const InputDecoration(
                          // fillColor: Colors.red,324
                          // border: OutlineInputBorder(),
                          // focusedBorder: OutlineInputBorder(),
                          labelStyle: TextStyle(),
                          alignLabelWithHint: true,
                          hintText: 'Enter a number between 0 to 100',
                          labelText: 'Enter your guess on Battery %'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: OutlinedButton(
                        onPressed: () {
                          late int rawGuessVal;
                          try {
                            rawGuessVal = int.parse(userInputController.text);
                          } catch (_) {
                            rawGuessVal = -1;
                          }

                          if (rawGuessVal >= 0 && rawGuessVal <= 100) {
                            print("Raw: Y $rawGuessVal");
                            setState(() {
                              guessPct = rawGuessVal;
                              showErrorMsg = false;
                            });
                            if (guessPct != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BatteryQuizResultPage(guessPct!)));
                            }
                            // procceed to next page;
                          } else {
                            print("Raw: N $rawGuessVal");
                            setState(() {
                              showErrorMsg = true;
                            });
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: Colors.black87,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          )),
                        ),
                        child: const Text("NEXT"),
                      ),
                    ),
                    Text(showErrorMsg ? "Please input a valid guess." : ""),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class BatteryQuizResultPage extends StatefulWidget {
  const BatteryQuizResultPage(this.guessPct, {super.key});

  final int guessPct;

  @override
  State<BatteryQuizResultPage> createState() => _BatteryQuizResultPageState();
}

class _BatteryQuizResultPageState extends State<BatteryQuizResultPage> {
  StreamSubscription? _batSub;
  int? batteryPct;

  @override
  void initState() {
    super.initState();

    _batSub = BatteryInfoPlugin().androidBatteryInfoStream.listen((event) {
      setState(() {
        batteryPct = event?.batteryLevel as int;
      });
    });
  }

  @override
  void dispose() {
    _batSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.customAppBar("Battery Test"),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your Guess % : ${widget.guessPct}"),
            Text("Actual Battery % : ${batteryPct!}"),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
              ),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: widget.guessPct == batteryPct
                  ? Text(
                      "You guessed it right!",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    )
                  : Text(
                      "Wrong guess",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
