
import 'dart:convert';

import 'package:flutter/material.dart';

class QrScannerOutput extends StatelessWidget {

  String output;
  QrScannerOutput({required this.output, super.key});

  @override
  Widget build(BuildContext context) {

// encoding_decoding.dart file is there which has the logic
// String decodedMsg = utf8.decode(base64.decode(output)); 


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("QR Scanner output"),
      ),
      body: Center(
        child: Container(
          
          child: Text("Output is : $output "),
        ),
      ),
    );
  }
}