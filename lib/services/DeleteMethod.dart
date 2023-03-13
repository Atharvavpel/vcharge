import 'package:http/http.dart' as http;

class PostMethod{
  static Future<void> deleteRequest(String url, String id) async{
    var response = await http.delete(Uri.parse(url + id));
    if(response.statusCode == 200){
      print("Delete successful");
    }else{
      print("Error deleting: ${response.statusCode}");
    }
  }
}