import 'dart:async';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:l08_broadcast_stuff/constants.dart';
// import 'package:battery_info/battery_info_plugin.dart';
// import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/android_battery_info.dart';

class BatteryPercentagePage extends StatefulWidget {
  const BatteryPercentagePage({super.key, required this.title});
  final String title;

  @override
  State<BatteryPercentagePage> createState() => _BatteryPercentagePageState();
}

// class NumberCreator {
//   NumberCreator([this.until = 69]) {
//     Timer.periodic(const Duration(seconds: 1), (t) {
//       if (_count == until) {
//         _controller.close();
//         return;
//       }
//       _controller.sink.add(_count);
//       _count++;
//     });
//   }
//   var _count = 1;
//   final int until;
//   final _controller = StreamController<int>();

//   Stream<int> get stream => _controller.stream;
// }

class _BatteryPercentagePageState extends State<BatteryPercentagePage> {
  // late BatteryState _batteryState;
  StreamSubscription? _batSub;
  int? batteryPct;
  int? guessPct;
  final userInputController = TextEditingController();
  bool showErrorMsg = false;

  @override
  void initState() {
    super.initState();

    _batSub = BatteryInfoPlugin().androidBatteryInfoStream.listen((event) {
      setState(() {
        batteryPct = event?.batteryLevel;
      });
    });
  }

  @override
  void dispose() {
    _batSub?.cancel();
    super.dispose();
  }

  // void updateState(BatteryState bstate) {
  //   print("Battery State on UpSt$bstate");
  //   setState(() {
  //     _batteryState = bstate;
  //   });
  // }
  // StreamBuilder(
  //     stream: NumberCreator(5).stream,
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Text("Waiting...");
  //       } else if (snapshot.connectionState ==
  //           ConnectionState.active) {
  //         return Text("Snapshot Data: ${snapshot.data}");
  //       } else {
  //         return Text("![Done or Error]!");
  //       }
  //     })

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
                    Container(
                      child: Text("DEBUG: Battery Pct: $batteryPct"),
                    ),
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
                          int rawGuessVal = int.parse(userInputController.text);
                          if (rawGuessVal >= 0 && rawGuessVal <= 100) {
                            print("Raw: Y $rawGuessVal");
                            setState(() {
                              guessPct = rawGuessVal;
                              showErrorMsg = false;
                            });
                            if (batteryPct != null && guessPct != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BatteryQuizResultPage(
                                              batteryPct!, guessPct!)));
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

class BatteryQuizResultPage extends StatelessWidget {
  const BatteryQuizResultPage(this.batteryPct, this.guessPct, {super.key});

  final int batteryPct;
  final int guessPct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.customAppBar("Battery Quiz Result"),
      body: Center(
          child: Container(
        child: Column(children: [
          Text("Your Guess % : $guessPct"),
          Text("Actual Battery % : $batteryPct"),
        ]),
      )),
    );
  }
}
