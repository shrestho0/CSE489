import 'package:_t02_firebase_auth/constants/constants.dart';
import 'package:_t02_firebase_auth/constants/utils.dart';
import 'package:_t02_firebase_auth/pages/firestore_crud.dart';
import 'package:_t02_firebase_auth/pages/realtime_fire.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AppHomePage(),
      routes: {
        '/firestore_crud': (context) => FireStoreCrudPage(),
        '/realtime_fire': (context) => RealtimeFirePage(),
      },
    );
  }
}

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.createAppBar(),
      body: Column(children: [
        Text("xx"),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Utils.navigateTo(context, '/firestore_crud'),
              child: const Text("FireStore CRUD"),
            ),
            ElevatedButton(
              onPressed: () => Utils.navigateTo(context, '/realtime_fire'),
              child: const Text("Real-time Fire"),
            ),
          ],
        ),
      ]),
    );
  }
}
