import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectivityPage extends StatefulWidget {
  const InternetConnectivityPage({super.key});

  @override
  State<InternetConnectivityPage> createState() =>
      _InternetConnectivityPageState();
}

class _InternetConnectivityPageState extends State<InternetConnectivityPage> {
  // late StreamSubscription<ConnectivityResult> subscription;
  dynamic subscription;
  List<bool> statuses = [];

  @override
  initState() {
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      setState(() {
        statuses = [];
      });
      statuses = await checkInternetStatus(result);
      setState(() {
        statuses = statuses;
      });
      // Got a new connectivity status!
    });
  }

// Be sure to cancel subscription after you are done
  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Internet Connectivity"),
        centerTitle: true,
      ),
      body: Center(
          child: Center(
        child: Text(statuses.length == 0
            ? "Checking..."
            : "Internet: ${boolToCustomString(statuses[0])}\nConnected with: ${statuses[1]&&statuses[2] ? 'all' : } "),
      )),
    );
  }
}

String boolToCustomString(bool val) {
  return val ? 'YES' : 'NO';
}

Future<List<bool>> checkInternetStatus(
  ConnectivityResult connectivityResult,
) async {
  // Checking if any internet accessible networks connected
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi ||
      connectivityResult == ConnectivityResult.ethernet) {
    // maybe connected
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      return [
        true,
        connectivityResult == ConnectivityResult.mobile,
        connectivityResult == ConnectivityResult.wifi
      ];
    }
  }
  return [
    false,
    connectivityResult == ConnectivityResult.mobile,
    connectivityResult == ConnectivityResult.wifi
  ];
}
