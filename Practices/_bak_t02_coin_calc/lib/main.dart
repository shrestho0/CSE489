import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.landscapeLeft, DeviceOrientation.portraitUp],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}

Widget takaTypeBuilder(BuildContext context, int ttype, int tcount) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 25),
    child: Text(
      "$ttype: $tcount",
      textAlign: TextAlign.right,
      style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final maxInteger = 9.0071993e+15;
  int taka = 0;
  int vangtiTaka = 0;
  var takaTypes = [500, 100, 50, 20, 10, 5, 2, 1];
  var takaCounts = [0, 0, 0, 0, 0, 0, 0, 0];
  var takaWidgetTopHalf = <Widget>[];
  var takaWidgetBottomHalf = <Widget>[];

  @override
  Widget build(BuildContext context) {
    takaWidgetTopHalf = [];
    takaWidgetBottomHalf = [];
    var numberButtonsWidgets = <Widget>[];

    for (var i = 0; i < takaCounts.length; i++) {
      if (i < takaTypes.length / 2) {
        takaWidgetTopHalf
            .add(takaTypeBuilder(context, takaTypes[i], takaCounts[i]));
      } else {
        takaWidgetBottomHalf
            .add(takaTypeBuilder(context, takaTypes[i], takaCounts[i]));
      }
    }

    void handleTakaAmountChange([int amount = 0, int inputType = 0]) {
      vangtiTaka = taka;
      for (var i = 0; i < takaCounts.length; i++) {
        if (i < takaTypes.length / 2) {
          takaWidgetTopHalf
              .add(takaTypeBuilder(context, takaTypes[i], takaCounts[i]));
        } else {
          takaWidgetBottomHalf
              .add(takaTypeBuilder(context, takaTypes[i], takaCounts[i]));
        }
      }

      for (var c = 0; c < takaTypes.length; c++) {
        takaCounts[c] += vangtiTaka ~/ takaTypes[c];
        vangtiTaka = vangtiTaka % takaTypes[c];
        print("Vangti $vangtiTaka $takaCounts");
      }
      if (taka > maxInteger) {
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

    for (var j = 0; j < 9; j++) {
      numberButtonsWidgets.add(ElevatedButton(
          onPressed: () => handleTakaAmountChange(j + 1, 0),
          child: Text("${j + 1}")));
    }

// []Widget createNumberButtons(){

// for(var i = 0; i < 11; i++){
//   if(i < 10){

//   }else{

//   }
// }
// return
// }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "VangtiChai",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
        foregroundColor: Colors.black,
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          var mediaHeight = MediaQuery.of(context).size.height;
          var mediaWidth = MediaQuery.of(context).size.width;
          return Container(
            color: Colors.grey[200],

            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            height: mediaHeight,
            width: mediaWidth,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  color: Colors.pink,
                  child: Container(
                    color: Colors.amber,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        taka == 0
                            ? 'Vangti Nai'
                            : "This shit doesn't work! :-3",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.pink,
                      width: orientation == Orientation.landscape
                          ? mediaWidth * 0.6
                          : mediaWidth * 0.3,
                      height: mediaHeight - 200,
                      child: Center(
                        child: GridView.count(
                          mainAxisSpacing: 0,
                          crossAxisCount:
                              orientation == Orientation.landscape ? 2 : 1,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: takaWidgetTopHalf,
                            ),
                            Column(
                              children: takaWidgetBottomHalf,
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: orientation == Orientation.landscape
                            ? mediaWidth * 0.4
                            : mediaWidth * 0.7,
                        child: Container(
                            height: mediaHeight - 200,
                            color: Colors.purple,
                            child: GridView.count(
                              crossAxisCount: 3,
                              children: [...numberButtonsWidgets],
                            )),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
