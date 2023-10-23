import 'dart:async';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:l08_broadcast_stuff/constants.dart';
import 'package:fbroadcast/fbroadcast.dart';
// import 'package:battery_info/model/android_battery_info.dart';

class CustomBroadcastPage extends StatefulWidget {
  const CustomBroadcastPage({super.key, required this.title});
  final String title;

  @override
  State<CustomBroadcastPage> createState() => _CustomBroadcastPageState();
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

class _CustomBroadcastPageState extends State<CustomBroadcastPage> {
  // late BatteryState _batteryState;

  final userInputController = TextEditingController();
  bool userCanSubmit = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void checkAndLetSubmit(String value) {
    print("Checking $value");
    setState(() {
      if (value.length > 2 && value.length < 100) {
        userCanSubmit = true;
      } else {
        userCanSubmit = false;
      }
    });
  }

  void handleNextPress() {
    if (!userCanSubmit) return;
    print("Sending message to Broadcast Receiver: ${userInputController.text}");
    // FBroadcast.instance().broadcast(
    //   /// message type
    //   "the_holy_broadcast",

    //   /// data
    //   value: userInputController.text,
    // );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TheHolyBroadcastReceiver(message: userInputController.text),
      ),
    );

    /// To Broadcast from Parent Activity
    // Timer(const Duration(milliseconds: 100), () {
    //   print("\n\n\n\nSending Data to next page with broadcast\n\n\n\n");

    //   FBroadcast.instance()
    //       .broadcast("the_holy_broadcast", value: userInputController.text);
    // });
  }

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
                    TextField(
                      controller: userInputController,

                      // autofocus: true,
                      // maxLength: 3,
                      style: const TextStyle(
                        // color: Colors.red,
                        fontSize: 18,
                      ),
                      onChanged: checkAndLetSubmit,

                      // style: ,
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(),
                          alignLabelWithHint: true,
                          hintText: 'anything...',
                          labelText: 'Enter your message to broadcast.'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: OutlinedButton(
                        onPressed: handleNextPress,
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
                    Text(
                        !userCanSubmit ? "Enter a text > 0 && text < 100" : ""),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class TheHolyBroadcastReceiver extends StatefulWidget {
  const TheHolyBroadcastReceiver({super.key, required this.message});
  final String message;

  @override
  State<TheHolyBroadcastReceiver> createState() =>
      _TheHolyBroadcastReceiverState();
}

class _TheHolyBroadcastReceiverState extends State<TheHolyBroadcastReceiver> {
  String theHolyMessage = '';

  @override
  void initState() {
    super.initState();

    // Subscribing (Register) to the broadcast
    FBroadcast.instance().register("the_holy_broadcast", (value, callback) {
      /// do something
      print("XDEBUG: Received something on the_holy_broadcast $value");
      setState(() {
        theHolyMessage = value;
      });
    });

    // Broadcasting the message from previous activity for the first time
    performHolyBroadcast(widget.message);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void performHolyBroadcast(String message) {
    FBroadcast.instance().broadcast("the_holy_broadcast", value: message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.customAppBar("Broadcast Receiver"),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.amber[50],
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              const Text(
                "Message Received from Previous activity:",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(widget.message),
            ]),
          ),
          OutlinedButton(
            onPressed: () => performHolyBroadcast(
                "${widget.message} - ${DateTime.now().toString()}"),
            child: const Text("BROADCAST MESSAGE"),
          ),
          Container(
            alignment: Alignment.center,
            // color: Colors.amber[100],
            height: 200,
            // padding: EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
                color: Colors.amber[100],
                border: Border.all(),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Received Data from Broadcast",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  "Received Message: $theHolyMessage",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
