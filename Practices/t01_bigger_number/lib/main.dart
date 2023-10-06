import "dart:math";
import 'package:flutter/material.dart';

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
  final description =
      "Welcome to the dumbest game ever created! Press the bigger number to get points. Nothing much.";

  var startChecking = false;
  var lastAnswerCorrect = false;

  int num1 = -1;
  int num2 = -1;

  void setNewRandomNumbers() {
    num1 = getRandomNumber(1000, 10000);
    num2 = getRandomNumber(1000, 10000);
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
      padding:
          const EdgeInsets.only(top: 100, bottom: 100, left: 25, right: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
          Column(
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
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  startChecking
                      ? lastAnswerCorrect
                          ? 'Correct'
                          : 'Incorrect'
                      : '',
                  style: TextStyle(
                    color: lastAnswerCorrect
                        ? Colors.greenAccent
                        : Colors.redAccent,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              "Points: $point",
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
