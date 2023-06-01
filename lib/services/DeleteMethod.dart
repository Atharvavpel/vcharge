import 'package:http/http.dart' as http;


class DeleteMethod{

  // this method handles the delete request with respect to the specific id:  
  // this method has been made static to make it available in complete project
  
  static Future<void> deleteRequest(String url) async{
    var response = await http.delete(Uri.parse(url));
    if(response.statusCode == 200){
    }else{
      print("Error deleting: ${response.statusCode}");
    }
  }
}