import 'dart:convert';
import 'package:http/http.dart' as http;

class GetMethod {
  // this method is used to fetch the details of the particular models

  static Future<dynamic> getRequest(String url) async {
    // print(url);
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // print(response.statusCode);
        return response.statusCode;
      }
    } catch (e) {
      // TODO
      print(e);
    }
  }

  //this method directly returns response
  static Future<http.Response> getRequestMod(String url) async {
    // print(url);
    var response;
    try {
      response = await http.get(Uri.parse(url));
      // return response;
    } catch (e) {
      print(e);
    }
    return response;
  }
}
