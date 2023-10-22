import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:l08_broadcast_stuff/constants.dart';

class WifiStatusPage extends StatefulWidget {
  const WifiStatusPage({super.key, required this.title});
  final String title;

  @override
  State<WifiStatusPage> createState() => _WifiStatusPageState();
}

class _WifiStatusPageState extends State<WifiStatusPage> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(setResultToState);
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    result = await _connectivity.checkConnectivity();

    if (!mounted) {
      return Future.value(null);
    }

    return setResultToState(result);
  }

  void setResultToState(ConnectivityResult result) {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.customAppBar(widget.title),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Text(
                "WIFI Connected: ${boolToYesNo(_connectionStatus == ConnectivityResult.wifi)}"),
          )),
    );
  }
}

String boolToYesNo(bool val) => val ? "YES" : "NO";
