import 'package:flutter/material.dart';
import 'package:l07_firebase/pages/data_page.dart';
import 'package:l07_firebase/pages/home_page.dart';
import 'package:l07_firebase/pages/list_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      routes: {
        '/home': (context) => MyHomePage(),
        '/data': (context) => DataPage(),
        '/list': (context) => ListPage(),
      },
    );
  }
}
