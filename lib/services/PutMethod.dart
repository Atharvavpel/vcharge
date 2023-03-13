import 'package:http/http.dart' as http;

class PutMethod{

  // this method is used to update the already existed object
  
  static Future<void> putRequest(String url, String id,dynamic body) async{
    var response = await http.put(
      Uri.parse(url + id),
      headers: {
        'Content-Type': 'application/json'
      },
      body: body
    );
    if(response.statusCode == 200){
      print('Put Successful');
    }else{
      print('Error: ${response.statusCode}');
    }
  }
}