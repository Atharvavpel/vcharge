import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vcharge/view/Security/LoginScreen.dart';

class EmailPasswordScreen extends StatefulWidget {
  final String phoneNumber;

  EmailPasswordScreen({required this.phoneNumber});

  @override
  _EmailPasswordScreenState createState() => _EmailPasswordScreenState();
}

class _EmailPasswordScreenState extends State<EmailPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> updateEmailAndPassword(String email, String password) async {
    String apiUrl =
        "http://192.168.0.243:8090/auth/registerUser/updateEmailAndPassword?userContactNo=${widget.phoneNumber}";

    Map<String, dynamic> requestBody = {
      "userEmail": email,
      "password": password,
    };

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
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      } else {
        print("API call failed with status code: ${response.statusCode}");
      }
    } catch (e) {
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
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
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
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
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
                            String email = emailController.text;
                            String password = passwordController.text;

                            updateEmailAndPassword(email, password);
                          },
                          child: const Text(
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
