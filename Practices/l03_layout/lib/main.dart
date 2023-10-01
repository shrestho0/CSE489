import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black,
          padding: const EdgeInsets.all(5),

          // backgroundColor: Colors.red,
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final SizedBox customMarginalSpace = const SizedBox(width: 10);

  void handleButtonPress(int buttonNumber) {
    print("Button:$buttonNumber Pressed!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Hello fuckin world!"),
      // ),
      body: Container(
        padding: EdgeInsets.only(top: 60),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: () => handleButtonPress(1),
                      child: const Text('B1'))
                ],
              ),
              Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                direction: Axis.horizontal,
                mainAxisSize: MainAxisSize.max,
                children: [
                  OutlinedButton(
                      onPressed: () => handleButtonPress(2),
                      child: const Text('B2')),
                  customMarginalSpace,
                  OutlinedButton(
                      onPressed: () => handleButtonPress(3),
                      child: const Text('Button Number 3')),
                  customMarginalSpace,
                  OutlinedButton(
                      onPressed: () => handleButtonPress(4),
                      child: const Text('B4'))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: () => handleButtonPress(5),
                      child: const Text('B5'))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  OutlinedButton(
                      onPressed: () => handleButtonPress(6),
                      child: const Text('B6'))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: () => handleButtonPress(7),
                      child: const Text('B7')),
                  customMarginalSpace,
                  OutlinedButton(
                      onPressed: () => handleButtonPress(8),
                      child: const Text('Button Number 8')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
