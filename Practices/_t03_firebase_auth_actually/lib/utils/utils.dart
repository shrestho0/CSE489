import 'package:flutter/material.dart';

class AppUtils {
  static AppBar commonAppBar(String title) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.black87,
      foregroundColor: Colors.white,
    );
  }
}
