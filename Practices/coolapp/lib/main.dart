import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  // this is where the programs starts executing...

  runApp(const MaterialApp(
    title: "Navigator App Basics",
    home: MyApp(),
  )); // inflates to screen
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyApp"),
      ),
      body: Center(
        child: Container(
          child: Column(children: [
            Text("Hello from MyApp"),
            ElevatedButton(
              child: Text("[ SecondPage ]"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
            )
          ]),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      ),
      body: Center(
        child: Container(
          child: Column(children: [
            Text("Hello from Second Pae"),
            ElevatedButton(
              child: Text("[ ThirdPage ]"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThirdPage()),
                );
              },
            ),
            ElevatedButton(
              child: Text("Back Home"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ]),
        ),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Third Page"),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Hello, fuckin world! "),
              ElevatedButton(
                child: Text("Back to Second"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                  child: Text("Back to ... "),
                  onPressed: () {
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
