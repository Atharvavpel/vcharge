import 'dart:convert';
import 'package:http/http.dart' as http;
  
class GetMethod {

  // this method is used to fetch the details of the particular models

  static Future<dynamic> getRequest(String url) async {
    var response = await http.get(Uri.parse(url));
    // print(url);
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    else{
      print(response.statusCode);
      return response.statusCode;
    }
  }
}
