import 'package:flutter/material.dart';

class QrScannerOutput extends StatelessWidget {
  String? output = "";
  QrScannerOutput({super.key, required this.output});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Scanner output"),
      ),
      body: Center(
        child: Container(
          child: Text("output: $output"),
        ),
      ),
    );
  }
}