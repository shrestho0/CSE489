import 'package:_t05_mvvm_partial/constants.dart';
import 'package:_t05_mvvm_partial/pages/something.dart';
import 'package:_t05_mvvm_partial/user_list/view_models/user_view_model.dart';
import 'package:_t05_mvvm_partial/user_list/views/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const TheHolyApplication());
}

class TheHolyApplication extends StatelessWidget {
  const TheHolyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserViewModel(),
        )
      ],
      child: MaterialApp(
        title: Constants.appTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Colors.black87,
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.black87,
              foregroundColor: Colors.white,
              titleSpacing: 10,
              centerTitle: true),
        ),
        home: HomePage(),
        routes: {
          '/something': (context) => SomethingPage(),
          '/user_list_page': (context) => UserListPage(),
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.appTitle),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Hello :3:3:3"),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/something');
              },
              child: const Text("something page"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/user_list_page');
              },
              child: const Text("User List Page"),
            ),
          ],
        ),
      ),
    );
  }
}
