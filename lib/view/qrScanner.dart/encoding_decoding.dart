import 'dart:convert';

String decrypt(String encodedMsg){

  print("the encoded message is: $encodedMsg");

  String decodedMsg = utf8.decode(base64.decode(encodedMsg));
  print("The decoded message is: $decodedMsg");
  return decodedMsg;
  
}