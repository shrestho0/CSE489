import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:p489_app/pages/auth_pages/auth_handler_page.dart';
import 'auth/firebase_options.dart';

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
      home: AuthHandlerPage(),

      /// routes will be here
      // routes: {
      //   '/'
      // },
    );
  }
}
