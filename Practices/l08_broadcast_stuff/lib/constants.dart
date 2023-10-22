import 'package:flutter/material.dart';

class Constants {
  static List<String> xRoutes = ["/", "/custom", "/wifi", "/battery"];
  static List<String> xRouteTitles = [
    "Broadcase489",
    "Custom Broadcast",
    "Wi-Fi State Change",
    "Battery Percentage "
  ];

  static AppBar customAppBar(String title) {
    return AppBar(
      backgroundColor: Colors.black87,
      foregroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        title,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
      ),
    );
  }
}
