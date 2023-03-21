import 'package:flutter/material.dart';

class MoreMenu extends StatelessWidget {
  const MoreMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: const Text("Welcome to the more-options page"),
        ),
      ),
    );
  }
}