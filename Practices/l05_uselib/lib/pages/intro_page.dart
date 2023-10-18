import 'package:flutter/material.dart';
import 'package:l05_uselib/pages/home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("INTRO_PAGE")),
      body: Center(
          child: ElevatedButton(
        child: const Text("Go to Home"),
        onPressed: () {
          /* REGULAR PUSH */
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => const HomePage(),
          //   ),
          // );

          /* NAMED PUSH */
          Navigator.pushNamed(context, '/homepage');

          // go to homepage
        },
      )),
    );
  }
}
