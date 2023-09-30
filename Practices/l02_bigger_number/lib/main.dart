import "dart:math";
import 'package:flutter/material.dart';

// void main() {
//   return runApp(
//     const MaterialApp(
//       home: MyApp(),
//       debugShowCheckedModeBanner: false,
//     ),
//   );
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   int _count = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("L01_Scaffold"),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Text("The Body! $_count"),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Text("click"),
//         onPressed: () => setState(() {
//           _count++;
//         }),
//       ),
//     );
//   }
// }

void main() {
  return runApp(
    const MaterialApp(
      home: MyGame(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyGame extends StatefulWidget {
  const MyGame({super.key});

  @override
  State<MyGame> createState() => _MyGameState();
}

int getRandomNumber(int minNumber, int maxNumber) {
  return minNumber + Random().nextInt(maxNumber - minNumber);
}

class _MyGameState extends State<MyGame> {
  final title = "Bigger Number Game";
  final description = "Some description about the game!!!";

  var startChecking = false;
  var lastAnswerCorrect = false;

  int num1 = -1;
  int num2 = -1;

  void setNewRandomNumbers() {
    num1 = getRandomNumber(69, 6969);
    num2 = getRandomNumber(69, 6969);
  }

  void handleButtonPress(int bType) {
    if (!startChecking) startChecking = true;
    if (bType == 0) {
      return setState(() {
        if (num1 > num2) {
          lastAnswerCorrect = true;
          point++;
        } else {
          lastAnswerCorrect = false;
        }
      });
    } else if (bType == 1) {
      return setState(() {
        if (num1 < num2) {
          lastAnswerCorrect = true;
          point++;
        } else {
          lastAnswerCorrect = false;
        }
      });
    }
  }

  var point = 0;

  @override
  Widget build(BuildContext context) {
    setNewRandomNumbers();
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(top: 100, bottom: 100, left: 25, right: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.grey[100],
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "$title",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '$description',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () => handleButtonPress(0),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: const BorderSide(width: 2.0, color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    child: Text("$num1"),
                  ),
                  OutlinedButton(
                    onPressed: () => handleButtonPress(1),
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: const BorderSide(width: 2.0, color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        )),
                    child: Text("$num2"),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "${startChecking ? lastAnswerCorrect : ''}",
                  style: TextStyle(
                    color: lastAnswerCorrect
                        ? Colors.greenAccent
                        : Colors.redAccent,
                  ),
                ),
              ),
            ],
          )),
          Center(
            child: Text("Points: $point"),
          )
        ],
      ),
    ));
  }
}

/*
Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Container(child: Text("xx")), Text("yyyy"), Text("yyyy")],
        ),

Padding(
          padding: EdgeInsets.only(top: 100, bottom: 100, left: 25, right: 25),
          child: Column(
            height: 100,
            width: 100,
            child: Text('xx'),
          )),
*/