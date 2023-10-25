import 'package:flutter/material.dart';

class SomeProvider extends ChangeNotifier {
  String someVal;

  SomeProvider({this.someVal = "some name"});

  void changeSomeVal({required String newVal}) async {
    someVal = newVal;
    notifyListeners();
  }
}
