import 'package:flutter/material.dart';
import 'package:football_score/football_score/model/football_model.dart';
import 'package:football_score/football_score/viewmodel/football_viewmodel.dart';
import 'package:provider/provider.dart';

class FootballPage extends StatefulWidget {
  const FootballPage({super.key});

  @override
  State<FootballPage> createState() => _FootballPageState();
}

class _FootballPageState extends State<FootballPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Football Score App"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Press get result button get scores"),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const FootballScoresPage();
                    },
                  ),
                );
              },
              child: const Text("Get Results"),
            )
          ],
        ),
      ),
    );
  }
}

class FootballScoresPage extends StatefulWidget {
  const FootballScoresPage({super.key});

  @override
  State<FootballScoresPage> createState() => _FootballScoresPageState();
}

class _FootballScoresPageState extends State<FootballScoresPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FootballViewModel>().getFootballScores();
    // print(context.read<FootballViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    FootballViewModel theVm = context.watch<FootballViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Football Score Page"),
        centerTitle: true,
      ),
      body: _ui(theVm),
    );
  }

  Widget _ui(FootballViewModel theVm) {
    if (theVm.loading) {
      return const Center(
          child: Column(
        children: [CircularProgressIndicator(), Text("Loading...")],
      ));
    } else if (theVm.hasError) {
      print("error ache");
      return Center(
        child: Column(
          children: [Text(theVm.errMsg)],
        ),
      );
    } else {
      // handle error here, later
      var tableRow = [];
      for (FootballScoreModel element in theVm.scoreList) {
        // print(element);
        tableRow.add(
          TableRow(
            children: [
              Center(child: TableCell(child: Text(element.Tournament))),
              Center(
                  child: TableCell(child: Text(element.Match_Id.toString()))),
              Center(child: TableCell(child: Text(element.Match_name))),
              Center(child: TableCell(child: Text(element.TeamA))),
              Center(child: TableCell(child: Text(element.TeamB))),
              Center(child: TableCell(child: Text(element.Score))),
            ],
          ),
        );
      }
      return Column(
        children: [
          Table(
            border: TableBorder.all(),
            // defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(1.2),
              4: FlexColumnWidth(1.2),
              5: FlexColumnWidth(),
            },
            children: [
              const TableRow(
                children: [
                  TableCell(child: Center(child: Text("Tournament"))),
                  TableCell(child: Center(child: Text("Match_Id"))),
                  TableCell(child: Center(child: Text("Match_name"))),
                  TableCell(child: Center(child: Text("TeamA"))),
                  TableCell(child: Center(child: Text("TeamB"))),
                  TableCell(child: Center(child: Text("Score"))),
                ],
              ),
              ...tableRow,
            ],
          ),
          // Expanded(
          //   child: ListView.builder(
          //     itemBuilder: (context, index) {
          //       FootballScoreModel fItem = theVm.scoreList[index];
          //       return Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //               "${fItem.Tournament},  ${fItem.Match_Id}, ${fItem.Match_name}, ${fItem.TeamA}, ${fItem.TeamB}, ${fItem.Score} "),
          //         ],
          //       );
          //     },
          //     itemCount: theVm.scoreList.length,
          //   ),
          // ),
        ],
      );
    }
  }
}
