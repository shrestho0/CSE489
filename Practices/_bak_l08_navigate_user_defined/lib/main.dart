import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:l08_navigate_user_defined/pages/AppScreen.dart';
import 'package:l08_navigate_user_defined/pages/BatteryPercentageScreen.dart';
import 'package:l08_navigate_user_defined/pages/CustomBroadcastScreen.dart';
import 'package:l08_navigate_user_defined/pages/InternetConnectivityScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: FToastBuilder(),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const AppScreen(),
      routes: {
        '/battery': (context) => BatteryPercentagePage(),
        '/internet': (context) => InternetConnectivityPage(),
        '/custom': (context) => CustomBroadcastPage(),
      },
    );
  }
}
