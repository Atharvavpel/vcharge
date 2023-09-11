import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../LoginScreen.dart';
import 'AdditionalDetailsScreen.dart';
import 'RegistrationScreen.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String phoneNumber;

  VerifyOtpScreen({required this.phoneNumber});
  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  List<TextEditingController> otpControllers =
      List.generate(4, (_) => TextEditingController());

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

  Future<void> verifyOtpRequest() async {
    try {
      String phoneNumber = widget.phoneNumber;
      String enteredOtp = otpControllers
          .map((controller) => controller.text)
          .join(); // Combine all OTP digit inputs
      String response = await verifyOtp(phoneNumber, int.parse(enteredOtp));

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
        builder: (context) =>
            AdditionalDetailsScreen(), // Create a LoginScreen widget.
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Image.asset(
        'assets/images/background.jpg', // Replace with your image asset path
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
      ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: Container(
            color: Colors.black.withOpacity(0),
          ),
        ),
      ),
      SingleChildScrollView(
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
                    "Enter the verification code",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Enter the Verification code we have send to ",
                          style: TextStyle(color: Colors.amber, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "(+91) ${widget.phoneNumber}",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: SingleChildScrollView(
                      child: Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                4,
                                (index) => SizedBox(
                                  width: 40,
                                  child: TextFormField(
                                    controller: otpControllers[index],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    maxLength: 1,
                                    decoration: const InputDecoration(
                                      counterText:
                                          "", // Hide the character count
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.amber, width: 2),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      // Automatically move focus to the next TextFormField when a digit is entered
                                      if (value.isNotEmpty && index < 3) {
                                        FocusScope.of(context).nextFocus();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
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
                      onPressed: verifyOtpRequest,
                      child: Text(
                        'Next',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't Receive Anything ? ",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) {
                              return AdditionalDetailsScreen();
                            },
                          ));
                        },
                        child: Text(
                          "Resend Code ",
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    ]));
  }
}
