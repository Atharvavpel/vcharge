import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'EmailPasswordScreen.dart';

class AdditionalDetailsScreen extends StatefulWidget {
  final String phoneNumber;

  AdditionalDetailsScreen({required this.phoneNumber});

  @override
  _AdditionalDetailsScreenState createState() =>
      _AdditionalDetailsScreenState();
}

class _AdditionalDetailsScreenState extends State<AdditionalDetailsScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  Future<void> updateUserDetails(String firstName, String lastName) async {
    String apiUrl =
        "http://192.168.0.243:8090/auth/registerUser/updateUserFirstNameAndLastName?userContactNo=${widget.phoneNumber}";

    Map<String, dynamic> requestBody = {
      "userFirstName": firstName,
      "userLastName": lastName,
    };

    // Convert the request body to JSON
    String requestBodyJson = json.encode(requestBody);

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: requestBodyJson,
      );

      if (response.statusCode == 200) {
        // Handle the success response here
        // You can navigate to the next screen or perform other actions
        // For example, you might navigate to the EmailPasswordScreen
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EmailPasswordScreen(
              phoneNumber: widget.phoneNumber,
            ),
          ),
        );
      } else {
        // Handle the API call failure here
        // You can show an error message to the user or take appropriate action
        print("API call failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      // Handle any exceptions that occur during the API call
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.jpg'), // Use AssetImage
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Colors.black12, Colors.transparent]),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 300, right: 10, left: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.black45,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Share More Details",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: EdgeInsets.only(left: 20),
                        child: TextField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                            labelText: 'First Name',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: EdgeInsets.only(left: 20),
                        child: TextField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 110,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                          onPressed: () {
                            // Get the values from the text controllers
                            String firstName = firstNameController.text;
                            String lastName = lastNameController.text;

                            // Call the API to update user details
                            updateUserDetails(firstName, lastName);
                          },
                          child: Text(
                            'Next',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
