import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vcharge/view/homeScreen/homeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _contactNumberOrEmailController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final storage = FlutterSecureStorage();
  final client = http.Client();
  bool _passwordVisible = false;

  Future<void> loginUser(String contactNumber, String password) async {
    final requestBody = {
      'userName': contactNumber,
      'password': password,
    };

    final requestBodyJson = json.encode(requestBody);

    print('Request Body: $requestBodyJson');

    final response = await http.post(
      Uri.parse(
          'http://192.168.0.243:8090/auth/loginUser/ByContactNoAndPassword'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestBodyJson,
    );

    if (response.statusCode == 200) {
      print('Received status code: 200 (OK)');

      final Map<String, dynamic> data = json.decode(response.body);
      final String token = data['token'];
      print(token);

      await storage.write(key: 'authToken', value: token);

      Login contactNumberLogin = Login(contactNumber, password);

      // Navigate to HomeScreen with contactNumberLogin
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) {
          print("Successfully logged in with contact number");
          return HomeScreen(
            login: contactNumberLogin,
          );
        },
      ));
    } else if (response.statusCode == 401) {
      print("Failed");

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Failed'),
            content:
                const Text('Invalid username or password. Please try again.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('An error occurred. Please try again later.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> loginU(String email, String password) async {
    final requestBody = {
      'userName': email,
      'password': password,
    };

    final requestBodyJson = json.encode(requestBody);

    print('Request Body: $requestBodyJson');

    final response = await http.post(
      Uri.parse('http://192.168.0.243:8090/auth/loginUser/ByEmailAndPassword'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestBodyJson,
    );

    if (response.statusCode == 200) {
      print('Received status code: 200 (OK)');

      final Map<String, dynamic> data = json.decode(response.body);
      final String token = data['token'];
      print(token);

      await storage.write(key: 'authToken', value: token);

      Login emailLogin = Login(email, password);

      // Navigate to HomeScreen with emailLogin
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) {
          print("Successfully logged in with email");
          return HomeScreen(
            login: emailLogin,
          );
        },
      ));
    } else if (response.statusCode == 401) {
      print("Failed");

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Failed'),
            content:
                const Text('Invalid username or password. Please try again.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('An error occurred. Please try again later.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
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
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Welcome Back !",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Please Login to continue our App",
                        style: TextStyle(color: Colors.white, fontSize: 20),
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
                              Icons.person,
                              size: 24,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _contactNumberOrEmailController,
                                decoration: const InputDecoration(
                                    labelText: 'Contact Number'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lock,
                              size:
                                  24, // Adjust the size to your preferred value
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                ),
                                obscureText: !_passwordVisible,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 130,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Request ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "OTP",
                                  style: TextStyle(color: Colors.amber),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final input = _contactNumberOrEmailController.text;
                          final password = _passwordController.text;

                          if (input.contains('@')) {
                            loginU(input, password);
                          } else {
                            loginUser(input, password);
                          }
                        },
                        child: const Text('Login'),
                      ),
                      Container(
                          padding: const EdgeInsets.all(1.0),
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
                      Container(
                        width: Get.width * 0.6,
                        height: Get.height * 0.05,
                        margin: EdgeInsets.only(
                            top: Get.height * 0.04, left: Get.width * 0.06),
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
                        children: const [
                          Text(
                            "Don't Have an Account? ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Register !",
                            style: TextStyle(color: Colors.amber),
                          ),
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
