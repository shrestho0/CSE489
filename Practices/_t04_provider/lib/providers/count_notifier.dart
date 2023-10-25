import 'package:flutter/material.dart';

class CountNotifier extends ChangeNotifier {
  int val;

  CountNotifier({this.val = 0});

  void incVal() {
    val++;
    notifyListeners();
  }
}
