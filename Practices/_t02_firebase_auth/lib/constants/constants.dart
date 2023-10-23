import 'package:flutter/material.dart';

class Constants {
  static const appName = "Firebase Stuff";
  static AppBar createAppBar([var title = appName]) {
    return AppBar(
      backgroundColor: Colors.black87,
      foregroundColor: Colors.white,
      centerTitle: true,
      title: Text(title),
    );
  }
}
