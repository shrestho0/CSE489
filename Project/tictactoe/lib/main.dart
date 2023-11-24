import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/configs/firebase_options.dart';
import 'package:tictactoe/pages/auth_pages/auth_handler_page.dart';
import 'package:tictactoe/pages/auth_pages/forgot_password_page.dart';
import 'package:tictactoe/pages/auth_pages/register_page.dart';

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
      title: 'tictactoe',
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.tealAccent, background: Colors.white),
        useMaterial3: true,
        fontFamily: "IBMPlexMono",
      ),
      home: const AuthHandlerPage(),

      /// routes will be here
      routes: {
        "/forgot-password": (context) => const ForgotPasswordPage(),
        "/register": (context) => const RegisterPage(),
      },
    );
  }
}
