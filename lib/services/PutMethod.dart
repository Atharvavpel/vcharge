import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class PutMethod{

  // this method is used to update the already existed object
  
  static Future<int> putRequest(String url, String id,var body) async{
    var response = await http.put(
      Uri.parse(url + id),
      headers: {
        'Content-Type': 'application/json'
      },
      body: body
    );
    return response.statusCode;
      
    //   Fluttertoast.showToast(
    //       // msg: "Data updated successfully",
    //       msg: response.body,
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.green,
    //       textColor: Colors.white,
    //       fontSize: 16.0);

    // }else{
    //   print('Error: ${response.statusCode}');
    // }
  }
}