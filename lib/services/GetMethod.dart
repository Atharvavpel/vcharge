import 'dart:convert';
import 'package:http/http.dart' as http;

class GetMethod {

  // this method is used to fetch the details of the particular models

  static Future<dynamic> getRequest(String url) async {
    print("inside the get method");
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      return json.decode(response.body);
    }
    else{
      return response.statusCode;
    }
  }
}
