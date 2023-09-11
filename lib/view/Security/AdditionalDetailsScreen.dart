import 'dart:ui';

import 'package:flutter/material.dart';

class AdditionalDetailsScreen extends StatefulWidget {
  @override
  _AdditionalDetailsScreenState createState() =>
      _AdditionalDetailsScreenState();
}

class _AdditionalDetailsScreenState extends State<AdditionalDetailsScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

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
                      onPressed: () {},
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
    ]));
  }
}
