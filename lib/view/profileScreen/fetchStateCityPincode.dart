import 'dart:convert';
import 'package:http/http.dart' as http;


Future fetchUserAddress(String stateName) async {

    // Make an HTTP GET request to the Indian Pincode API
http.Response response = await http.get(Uri.parse('https://api.postalpincode.in/pincode/$stateName'));

// Check if the response was successful
if (response.statusCode == 200) {
  // Parse the JSON response
  var jsonResponse = json.decode(response.body);
  
  // Extract the city, state, and pincode information
  String city = jsonResponse[0]['PostOffice'][0]['District'];
  String state = jsonResponse[0]['PostOffice'][0]['State'];
  String pincode = jsonResponse[0]['PostOffice'][0]['Pincode'];
  
  // Update the corresponding text fields with the fetched information
  // cityController.text = city;
  // stateController.text = state;
  // pincodeController.text = pincode;
} else {
  // Handle the error
  print('Request failed with status: ${response.statusCode}.');
}


  }