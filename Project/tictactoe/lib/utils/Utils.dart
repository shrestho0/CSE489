import 'package:flutter/material.dart';

// class Utils {
// }

Widget someFreeSpace({double height = 100, double width = 100}) {
  return SizedBox(height: height, width: height);
}

AppBar customAppBar(String title) {
  return AppBar(
    backgroundColor: Colors.black87,
    centerTitle: true,
    title: Text(
      title,
      style:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
    ),
  );
}
