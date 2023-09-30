import 'package:flutter/material.dart';

void main() {
  return runApp(
    const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("L01_Scaffold"),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text("The Body!"),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Text("click"),
//         onPressed: () => {print("X")},
//       ),
//     );
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("L01_Scaffold"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("The Body! $_count"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text("click"),
        onPressed: () => setState(() {
          _count++;
        }),
      ),
    );
  }
}

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("L01_Scaffold"),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Text("The Body!"),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Text("click"),
//         onPressed: () => {print("X")},
//       ),
//     );
//   }
// }
