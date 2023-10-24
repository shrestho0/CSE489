import 'package:_t03_firebase_auth_actually/firebase_options.dart';
import 'package:_t03_firebase_auth_actually/pages/LoginPage.dart';
import 'package:_t03_firebase_auth_actually/protected/UserHomePage.dart';
import 'package:_t03_firebase_auth_actually/services/firebase_auth.dart';
import 'package:_t03_firebase_auth_actually/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => LoginPage(),
        '/user_home_page': (context) => UserHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User? user = FirebaseAuthService().getUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUtils.commonAppBar("The App"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              user != null
                  ? 'User Logged In as ${user?.email}'
                  : 'User NOT Logged In',
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber[50],
                ),
                child: Text("Go To Loginpage"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/user_home_page');
              },
              child: Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber[50],
                ),
                child: Text("Go to user page"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
