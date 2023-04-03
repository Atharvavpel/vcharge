import 'dart:convert';
import 'package:http/http.dart' as http;

class GetMethod {

  // this method is used to fetch the details of the particular models

  static Future<List<dynamic>> getRequest(String url) async {
    var response = await http.get(Uri.parse(url));
    print(response);
    var body = response.body;
    return jsonDecode(body);
  }
}
