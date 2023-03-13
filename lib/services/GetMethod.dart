import 'dart:convert';
import 'package:http/http.dart' as http;

class GetMethod {
  static Future<List<dynamic>> getRequest(String url) async {
    var response = await http.get(Uri.parse(url));
    var body = response.body;
    return jsonDecode(body);
  }
}
