import 'package:flutter/material.dart';
import 'package:l08_broadcast_stuff/constants.dart';
import 'package:l08_broadcast_stuff/pages/battery_page.dart';
import 'package:l08_broadcast_stuff/pages/custom_broadcast.dart';
import 'package:l08_broadcast_stuff/pages/wifi_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        debugShowCheckedModeBanner: false,
        routes: {
          Constants.xRoutes[0]: (context) =>
              MyHomePage(title: Constants.xRouteTitles[0]),
          Constants.xRoutes[1]: (context) =>
              CustomBroadcastPage(title: Constants.xRouteTitles[1]),
          Constants.xRoutes[2]: (context) =>
              WifiStatusPage(title: Constants.xRouteTitles[2]),
          Constants.xRoutes[3]: (context) =>
              BatteryPercentagePage(title: Constants.xRouteTitles[3]),
        });
  }
}

class UstaderPlaceholder extends StatelessWidget {
  const UstaderPlaceholder({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.customAppBar(title),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
            ),
          ],
        ),
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
  String selectedItem = '/';
  bool showCantProccedMsg = false;

  void handleNextAfterSelection() {
    if (selectedItem == '/') {
      setState(() {
        showCantProccedMsg = true;
      });
      return;
    }

    Navigator.pushNamed(context, selectedItem);
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.normal),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Container(
                  height: 50,
                  margin: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  // decoration: myBoxDecoration(),
                  child: const Column(
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      Text("Select a page and tap next to explore more..."),
                    ],
                  )),
            ),
            Container(
              // color: Colors.lightGreenAccent,
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              alignment: Alignment.center,
              child: Column(
                children: [
                  DropdownMenu(
                    dropdownMenuEntries:
                        getDDItems(Constants.xRoutes, Constants.xRouteTitles),
                    onSelected: (value) => setState(() {
                      setState(() {
                        if (showCantProccedMsg) showCantProccedMsg = false;
                      });
                      selectedItem = value.toString();
                    }),
                    width: MediaQuery.of(context).size.width - 40,
                    menuStyle: const MenuStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                        shadowColor:
                            MaterialStatePropertyAll(Colors.transparent)),
                    hintText: "Select from the list",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: OutlinedButton(
                      onPressed: handleNextAfterSelection,
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Colors.black87,
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        )),
                      ),
                      child: const Text("NEXT"),
                    ),
                  ),
                ],
              ),
            ),
            Text(
                "${showCantProccedMsg ? 'you must select one to proceed' : ''}"),
          ],
        ),
      ),
    );
  }
}

List<DropdownMenuEntry> getDDItems(
    List<String> xRoutes, List<String> xRouteTitles) {
  List<DropdownMenuEntry> xDDList = [];

  for (var i = 0; i < xRoutes.length; i++) {
    if (i == 0) continue;
    xDDList.add(DropdownMenuEntry(
      value: xRoutes[i],
      label: xRouteTitles[i],
    ));
  }

  return xDDList;
}
