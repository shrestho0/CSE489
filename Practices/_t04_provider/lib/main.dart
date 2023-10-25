import 'package:_t04_provider/CountPage.dart';
import 'package:_t04_provider/providers/count_notifier.dart';
import 'package:_t04_provider/providers/some_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SomeProvider(someVal: "initial val"),
        ),
        ChangeNotifierProvider(
          create: (context) => CountNotifier(val: 69),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
        routes: {
          '/count': (context) => CountPage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var someValController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${context.watch<CountNotifier>().val}"),
            Text(context.watch<SomeProvider>().someVal),
            const Text(
              'You have pushed the button this many times:',
            ),
            TextField(
              controller: someValController,
            ),
            ElevatedButton(
                onPressed: () {
                  context
                      .read<SomeProvider>()
                      .changeSomeVal(newVal: someValController.text);
                },
                child: Text("Change text :3")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/count');
                },
                child: Text("Count"))
          ],
        ),
      ),
    );
  }
}
