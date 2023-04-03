import 'package:http/http.dart' as http;


class PostMethod{

  // this method handles the delete request with respect to the specific id:  
  // this method has been made static to make it available in complete project
  
  static Future<void> deleteRequest(String url, String id) async{
    var response = await http.delete(Uri.parse(url + id));
    if(response.statusCode == 200){
    }else{
      print("Error deleting: ${response.statusCode}");
    }
  }
}