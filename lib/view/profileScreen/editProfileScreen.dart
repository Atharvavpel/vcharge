import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vcharge/services/GetMethod.dart';
import 'package:vcharge/services/putMethod.dart';
import 'package:vcharge/view/settingScreen/settingPage.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
// variables for storing the values in the sections
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

// function for fetching specific user data
  Future<void> getUserData() async {
    var data = await GetMethod.getRequest(
        "http://192.168.0.41:8081/manageUser/user?userId=USR20230405172425672");

    if (data != null) {
      setState(() {
        firstNameController.text = data['userFirstName'];
        lastNameController.text = data['userLastName'];
        dobController.text = data['userDateOfBirth'];
        genderController.text = data['userGender'];
        emailController.text = data['userEmail'];
        addressController.text = data['userAddress'];
        pincodeController.text = data['userPincode'];
        cityController.text = data['userCity'];
      });
    }
  }

// function for updating the specific user data
  Future updateUserDetails() async {
    var response = await PutMethod.putRequest(
        "http://192.168.0.41:8081/manageUser/user?userId=",
        "USR20230405172425672",
        jsonEncode({
          'userFirstName': firstNameController.text,
          'userLastName': lastNameController.text,
          'userDateOfBirth': dobController.text,
          'userGender': genderController.text,
          'userEmail': emailController.text,
          'userAddress': addressController.text,
          'userPincode': pincodeController.text,
          'userCity': cityController.text
        }));

    print("Success");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Profile"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // container for name section
        
              Row(
                children: [
                  // container for first name
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        cursorColor: Colors.green,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            label: Text("First-Name"),
                            border: OutlineInputBorder()),
                        controller: firstNameController,
                      ),
                    ),
                  ),
        
                  // container for last name
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        cursorColor: Colors.green,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            label: Text("Last-Name"),
                            border: OutlineInputBorder()),
                        controller: lastNameController,
                      ),
                    ),
                  )
                ],
              ),
        
              // contianer for dob and gender
        
              Row(
                children: [
                  // container for date of birth
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        cursorColor: Colors.green,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            label: Text("Date of Birth"),
                            border: OutlineInputBorder()),
                        controller: dobController,
                      ),
                    ),
                  ),
        
                  // container for gender
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        cursorColor: Colors.green,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            label: Text("Gender"),
                            border: OutlineInputBorder()),
                        controller: genderController,
                      ),
                    ),
                  )
                ],
              ),
        
              // container for Email section
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  cursorColor: Colors.green,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      label: Text("Email"), border: OutlineInputBorder()),
                  controller: emailController,
                ),
              ),
        
              // container for Address section
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                    minLines: 1,
                    maxLines: 10,
                    cursorColor: Colors.green,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        label: Text("Address"), border: OutlineInputBorder()),
                    controller: addressController,
                  ),
              ),
        
              // contianer for dob and gender
        
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        cursorColor: Colors.green,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            label: Text("Pincode"),
                            border: OutlineInputBorder()),
                        controller: pincodeController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        cursorColor: Colors.green,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            label: Text("City"), border: OutlineInputBorder()),
                        controller: cityController,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          updateUserDetails();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SettingPage()));
        },
        label: const Text("Update"),
      ),
    );
  }
}
