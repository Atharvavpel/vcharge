import 'package:http/http.dart' as http;

class PostMethod{
  static Future<void> postRequest(String url, dynamic body) async{
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json'
      },
      body: body
    );
    if(response.statusCode == 200){
      print('Post Successful');
    }else{
      print('Error: ${response.statusCode}');
    }
  }
}