import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("HOME_PAGE")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Count: $count"),
          ElevatedButton(
            child: const Text("Count++"),
            onPressed: () {
              setState(() {
                count++;
              });
              // go to homepage
            },
          ),
          Center(
            child: ElevatedButton(
              child: const Text("Count++"),
              onPressed: () {
                Navigator.pushNamed(context, '/intropage');
                // go to homepage
              },
            ),
          )
        ],
      ),
    );
  }
}
