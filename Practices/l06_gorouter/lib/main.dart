import 'dart:async';
import 'package:flutter/material.dart';
import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/enums/charging_status.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
      routes: {
        '/home': (context) => const Home(),
        '/about': (context) => const About(),
        '/battery': (context) => const BatteryPage(),
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var home_count = 0;
  void _inc_count() {
    setState(() {
      home_count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("HomePage"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Count $home_count"),
          ElevatedButton(
              onPressed: _inc_count, child: const Text("home_count++")),
          ElevatedButton(
            child: const Text("Go To About Page"),
            onPressed: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
          ElevatedButton(
            child: const Text("Go To Batttery Page"),
            onPressed: () {
              Navigator.pushNamed(context, '/battery');
            },
          ),
        ],
      ),
    );
  }
}

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  var about_count = 0;
  void _inc_count() {
    setState(() {
      about_count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("AboutPage"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Count $about_count"),
          ElevatedButton(
              onPressed: _inc_count, child: const Text("about_count++")),
          ElevatedButton(
            child: const Text("Go To About Page"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key});

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Battery Stuff"),
        ),
        body: Center(
          child: Column(children: [
            StreamBuilder(
                stream: BatteryInfoPlugin().androidBatteryInfoStream,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return Column(
                    children: [
                      Text(
                          "Charging status: ${(snapshot.data.chargingStatus.toString().split(".")[1])}"),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Battery Level: ${(snapshot.data.batteryLevel)} %"),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                }),
          ]),
        ));
  }
}
