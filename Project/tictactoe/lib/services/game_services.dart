import 'package:flutter/material.dart';

class GameServices extends ChangeNotifier {
  bool _loading = false;
  get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
