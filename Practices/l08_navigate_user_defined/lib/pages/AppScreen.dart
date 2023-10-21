import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

// const List<String> Screens = <String>[
//   'Select one',
//   'Battery',
//   'Internet',
//   'Custom'
// ];
const Map Screens = {
  'n/a': 'Select one',
  'custom': 'Custom',
  'internet': 'Internet',
  'battery': 'Battery',
};

class _AppScreenState extends State<AppScreen> {
  String selectedPage = 'n/a';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("MyApp"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$selectedPage"),
            DropdownMenu(
              onSelected: (value) => setState(() {
                selectedPage = value;
              }),
              initialSelection: 'n/a',
              dropdownMenuEntries: Screens.entries.map((e) {
                return DropdownMenuEntry(
                  value: e.key,
                  label: e.value,
                );
              }).toList(),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  if (selectedPage == 'n/a') {
                    Fluttertoast.showToast(
                      msg: "Please select one to continue...",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      fontSize: 16.0,
                    );
                  } else {
                    Navigator.pushNamed(
                      context,
                      "/$selectedPage",
                    );
                  }
                },
                child: const Text("Next"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
