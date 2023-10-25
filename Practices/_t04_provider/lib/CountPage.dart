import 'package:_t04_provider/providers/count_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountPage extends StatelessWidget {
  const CountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Count")),
      body: Center(
        child: Column(children: [
          Text("CountNotifier"),
          Text("${context.watch<CountNotifier>().val}"),
          ElevatedButton(
              onPressed: () {
                context.read<CountNotifier>().incVal();
              },
              child: Text("inc")),
        ]),
      ),
    );
  }
}
