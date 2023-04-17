// this widget is responsible for decoding the encrypted scanner output and 
// resume the further process once initiated



/*


qr codes used to test is:
encQR1 ..... QR3
Key: 1234

*/










/*

import 'package:flutter/material.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';

class QrScannerOutput extends StatelessWidget {

String? output = "";
QrScannerOutput({super.key, required this.output});

void initState(){
  decrypt();
}

late PlatformStringCryptor cryptor;
String decryptedtext = " ";

void decrypt() async {
    try {
      String decrypted = await cryptor.decrypt(output, "1234");
        decryptedtext = decrypted;
    } on MacMismatchException {
      decryptedtext = "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Scanner output"),
      ),
      body: Center(
        child: Container(
          child: Text("decrypted output is: $decryptedtext"),
        ),
      ),
    );
  }
}

*/








/*

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class QrScannerOutput extends StatelessWidget {
  final String? encryptedText;

  QrScannerOutput({required this.encryptedText});
  late String decrypted = " ";

  void main() {
  final key = encrypt.Key.fromUtf8('1234');
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: "PKCS7", iv: iv));

  final encrypted = encrypter.encrypt('my secret message');
  decrypted = encrypter.decrypt(encrypted);

  print(decrypted); // 'my secret message'
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Decrypted Text'),
      ),
      body: Center(
        child: Text(
          decrypted,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

*/





import 'dart:convert';

import 'package:flutter/material.dart';

class QrScannerOutput extends StatelessWidget {

  String output;
  QrScannerOutput({required this.output, super.key});

  @override
  Widget build(BuildContext context) {

// this is used for encoding the logic ---> also encoding_decoding.dart file is also there which has the logic
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