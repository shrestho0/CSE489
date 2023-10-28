import 'package:_t06_mvvm_partial2/person_view.dart';
import 'package:_t06_mvvm_partial2/person_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PersonViewModel(),
        )
      ],
      child: const MyApp(),
    ),
  );
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
      home: const TheApp(),
      routes: {
        '/persons': (context) => PersonView(),
      },
    );
  }
}

class TheApp extends StatefulWidget {
  const TheApp({super.key});

  @override
  State<TheApp> createState() => _TheAppState();
}

class _TheAppState extends State<TheApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[100],
        title: Text(
          "The App",
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text("xx"),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/persons');
              },
              child: Container(
                color: Colors.amber[100],
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.all(20),
                child: Text("Persons with MVVM "),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
