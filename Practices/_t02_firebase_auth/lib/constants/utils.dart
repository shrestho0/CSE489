import 'package:flutter/material.dart';

class Utils {
  static void navigateTo(BuildContext context, String path) {
    Navigator.pushNamed(context, path);
  }

  // UI Utils

  static Center wwContainer(Widget theWidget, Color color) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: color,
            border: Border.all(),
            borderRadius: BorderRadius.circular(10)),
        child: theWidget,
      ),
    );
  }
}
