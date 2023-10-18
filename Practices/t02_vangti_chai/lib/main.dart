import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t02_vangti_chai/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: AppConstants().themeUseMaterial3),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstants().appBarBackgroundColor,
          foregroundColor: AppConstants().appBarForegroundColor,
          title: Text(
            AppConstants().appBarTitle,
            style: TextStyle(
                fontSize: AppConstants().appBarTitleFontSize,
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
          return const TheVangtiChaiApp();
        }),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TheVangtiChaiApp extends StatefulWidget {
  const TheVangtiChaiApp({super.key});

  @override
  State<TheVangtiChaiApp> createState() => _TheVangtiChaiAppState();
}

class _TheVangtiChaiAppState extends State<TheVangtiChaiApp> {
  int taka = 0;

  void handleTakaAmountChange([int amount = 0, int inputType = 0]) {
    if (taka > AppConstants().maxInteger) {
      setState(() {
        taka = 0;
      });
      return;
    }
    // 0 -> change taka
    // 1 -> Clear Stuff
    if (inputType == 0) {
      setState(() {
        taka = taka * 10 + amount;
      });
    } else if (inputType == 1) {
      setState(() {
        taka = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    // const landscape = Orientation.landscape;
    const portrait = Orientation.portrait;
    List<Widget> numberButtonsWidgets = [];

    final vangtiButtonStyle = OutlinedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: Colors.grey[200],
    );

    for (var j = 0; j < 11; j++) {
      numberButtonsWidgets.add(OutlinedButton(
        style: vangtiButtonStyle,
        onPressed: () => handleTakaAmountChange((j + 1) % 10, j < 10 ? 0 : 1),
        child: Text(j < 10 ? "${(j + 1) % 10}" : "Clear"),
      ));
    }

    List<int> xCoins = calculateCoinCount(AppConstants().takaTypes, taka);
    List<Widget> xVangtiWidgets =
        buildtakaTypeAndCount(AppConstants().takaTypes, xCoins);
    // print("Taka: $taka, $xCoins");

    return Column(
      children: [
        SizedBox(
          height: AppConstants().takaAmountContainerHeight,
          width: MediaQuery.of(context).size.width,
          // color: Colors.deepPurpleAccent,
          child: Center(
            child: Text(
              taka == 0 ? 'Vangti Nai' : "Taka: $taka",
              style: TextStyle(
                fontWeight: AppConstants().takaAmountFontWeight,
                fontSize: AppConstants().takaAmountFontSize,
              ),
            ),
          ),
        ),
        Container(
          // height: MediaQuery.of(context).size.height - 40 - kToolbarHeight - 50,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[50],
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: orientation == portrait
                    ? MediaQuery.of(context).size.width *
                        AppConstants().portraitRelativeSizeLeft
                    : MediaQuery.of(context).size.width *
                        AppConstants().portraitRelativeSizeRight,
                child: Container(
                  // color: Colors.tealAccent,
                  alignment: Alignment.center,
                  child: orientation == portrait
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: xVangtiWidgets,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: xVangtiWidgets.sublist(0, 4),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: xVangtiWidgets.sublist(
                                4,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              SizedBox(
                // height: MediaQuery.of(context).size.height - 120,
                width: orientation == portrait
                    ? MediaQuery.of(context).size.width *
                        AppConstants().portraitRelativeSizeRight
                    : MediaQuery.of(context).size.width *
                        AppConstants().portraitRelativeSizeLeft,
                child: Container(
                  // height: 500,
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.all(AppConstants().inputButtonCommonPadding),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: numberButtonsWidgets.sublist(0, 3),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: numberButtonsWidgets.sublist(3, 6),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: numberButtonsWidgets.sublist(6, 9),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            numberButtonsWidgets[9],
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: AppConstants().clearButtonPaddingLeft,
                                    right:
                                        AppConstants().clearButtonPaddingRight),
                                child: numberButtonsWidgets[10],
                              ),
                            )
                          ],
                        )
                      ]),
                  // child: GridView.count(
                  //   crossAxisCount: 3,
                  //   padding: EdgeInsets.all(20),
                  //   children: [
                  //     ...numberButtonsWidgets,
                  //   ],
                  //   crossAxisSpacing: 10,
                  //   mainAxisSpacing: 10,
                  // ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

List<int> calculateCoinCount(List<int> takaTypes, int taka) {
  var takaCounts = [0, 0, 0, 0, 0, 0, 0, 0];

  for (var i = 0; i < takaTypes.length; i++) {
    var coinCount = taka ~/ takaTypes[i];
    taka = taka % takaTypes[i];
    // print("Coin ${takaTypes[i]} $coinCount");
    takaCounts[i] = coinCount;
  }

  return takaCounts;
}

List<Widget> buildtakaTypeAndCount(List takaTypesX, List takaCountsX) {
  List<Widget> takaWidgets = [];

  for (var i = 0; i < takaTypesX.length; i++) {
    Widget X = Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(
          vertical: AppConstants().vangtiCountPaddingVertical,
          horizontal: AppConstants().vangtiCountPaddingHorizontal),
      // child:
      //   Center(
      child: Text(
        "${takaTypesX[i]}: ${takaCountsX[i]}",
        // textAlign: TextAlign.right,
        style: TextStyle(
            fontSize: AppConstants().vangtiCountFontSize,
            fontWeight: AppConstants().vangtiCountFontWeight),
        // ),
      ),
    );

    takaWidgets.add(X);
  }

  return takaWidgets;
}
