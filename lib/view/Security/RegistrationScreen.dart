import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:vcharge/view/LoginScreen.dart';
import 'package:vcharge/view/Security/VerifyOtpScreen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController phoneNumberController = TextEditingController();

  void sendOtpRequest() async {
    String phoneNumber = phoneNumberController.text;
    final response = await http.get(
      Uri.parse(
          "http://192.168.0.243:8090/auth/registerUser/sendOtp?phoneNumber=$phoneNumber"),
    );

    if (response.statusCode == 200) {
      // Navigate to the Verify OTP screen and pass the phoneNumber as an argument.
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => VerifyOtpScreen(
              phoneNumber: phoneNumber), // Pass the phoneNumber.
          settings: RouteSettings(arguments: phoneNumber),
        ),
      );
    } else {
      // Handle the error if the request fails.
      print("Request failed with status: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                        "Let's Get Started !",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: const Text(
                          "Enter your phone number in order to send you your OTP security code",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone,
                              size: 24,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: phoneNumberController,
                                decoration: const InputDecoration(
                                    prefixText: "+91",
                                    labelText: 'Contact Number'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already Have an Account? ",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return LoginScreen();
                                },
                              ));
                            },
                            child: Text(
                              "Login !",
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 18,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        ],
                      )),
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
                          onPressed: sendOtpRequest,
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
                          child: Row(children: const <Widget>[
                        Expanded(
                            child: Divider(
                          indent: 50,
                          endIndent: 20,
                          color: Colors.white,
                          thickness: 1,
                        )),
                        Text(
                          "OR",
                          style: TextStyle(color: Colors.white),
                        ),
                        Expanded(
                            child: Divider(
                          indent: 20,
                          endIndent: 50,
                          color: Colors.white,
                          thickness: 1,
                        )),
                      ])),
                      SizedBox(height: 13),
                      Text(
                        "Continue With ",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Container(
                        width: Get.width * 0.6,
                        height: Get.height * 0.05,
                        margin: EdgeInsets.only(
                            top: Get.height * 0.02, left: Get.width * 0.06),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // facebook icon
                            Container(
                              width: Get.width * 0.07,
                              margin: EdgeInsets.only(right: Get.width * 0.04),
                              child: GestureDetector(
                                  onTap: () {},
                                  child:
                                      Image.asset("assets/images/google.png")),
                            ),

                            Container(
                              width: Get.width * 0.09,
                              margin: EdgeInsets.only(right: Get.width * 0.04),
                              child: GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                      "assets/images/facebook.png")),
                            ),

                            // twitter icon
                            Container(
                              width: Get.width * 0.09,
                              margin: EdgeInsets.only(right: Get.width * 0.04),
                              child: GestureDetector(
                                  onTap: () {},
                                  child:
                                      Image.asset("assets/images/apple.png")),
                            ),
                          ],
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
                            "I Accept the ",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return RegistrationScreen();
                                },
                              ));
                            },
                            child: Text(
                              "Terms & Conditions",
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 15,
                                decoration: TextDecoration.underline,
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
        ],
      ),
    );
  }
}
