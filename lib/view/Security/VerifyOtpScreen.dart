import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../LoginScreen.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String phoneNumber;

  VerifyOtpScreen({required this.phoneNumber});
  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  TextEditingController otpController = TextEditingController();

  Future<String> verifyOtp(String phoneNumber, int otp) async {
    final response = await http.get(
      Uri.parse(
          "http://192.168.0.243:8090/auth/registerUser/verifyOtp?phoneNumber=$phoneNumber&otp=$otp"),
    );

    if (response.statusCode == 200) {
      return response
          .body; // Response from the API (e.g., {"status":"success"})
    } else {
      throw Exception("Failed to verify OTP");
    }
  }

  void verifyOtpRequest() async {
    try {
      String phoneNumber = widget.phoneNumber;
      int enteredOtp = int.parse(otpController.text);
      String response = await verifyOtp(phoneNumber, enteredOtp);

      final status = jsonDecode(response)["status"];

      if (status == "success") {
        // OTP is verified successfully; navigate to the Login screen.
        navigateToLoginScreen();
      } else if (status == "userExists") {
        // Handle the case where the user already exists (if needed).
      } else if (status == "invalid") {
        // Handle the case where the OTP is invalid (if needed).
      } else {
        // Handle other cases as needed.
      }
    } catch (e) {
      // Handle any errors that occur during OTP verification or network issues.
      print("Error: $e");
    }
  }

  void navigateToLoginScreen() {
    // Navigate to the Login screen (you need to create the LoginScreen widget).
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen(), // Create a LoginScreen widget.
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Enter OTP sent to ${widget.phoneNumber}'),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'OTP',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: verifyOtpRequest,
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
