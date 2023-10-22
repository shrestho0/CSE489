import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BatteryPercentagePage extends StatefulWidget {
  const BatteryPercentagePage({super.key});

  @override
  State<BatteryPercentagePage> createState() => _BatteryPercentagePageState();
}

class _BatteryPercentagePageState extends State<BatteryPercentagePage> {
  final userInputController = TextEditingController();

  @override
  void dispose() {
    userInputController.dispose();
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
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: userInputController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
              autofocus: true,
              maxLength: 3,
              decoration: const InputDecoration(
                alignLabelWithHint: true,
                hintText: 'Enter your guess on Battery %',
              ),
            ),
          ),
          OutlinedButton(
            child: Text("next"),
            onPressed: () {
              print('next ${userInputController.text}');
            },
          ),
        ],
      )),
    );
  }
}
