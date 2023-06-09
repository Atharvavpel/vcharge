import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vcharge/services/GetMethod.dart';
import 'package:vcharge/services/putMethod.dart';
import 'package:vcharge/services/redisConnection.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {

  String userId;

  String? firstNameEdited;
  String? lastNameEdited;
  String? emailIdEdited;
  String? contactNoEdited;

  EditProfileScreen({super.key, 
  

                    required this.userId, 
                    required this.firstNameEdited,
                    required this.lastNameEdited,
                    required this.contactNoEdited,
                    required this.emailIdEdited,
                });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

// variables for storing the values in the sections
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();


  //variables for DropDown menu for vehicle selection
  List<String> genderList = ['male', 'female', 'other'];
  dynamic selectedGender;

// list for states in India
  List<String> statesIndia = [
  'Andhra Pradesh',
  'Arunachal Pradesh',
  'Assam',
  'Bihar',
  'Chhattisgarh',
  'Goa',
  'Gujarat',
  'Haryana',
  'Himachal Pradesh',
  'Jharkhand',
  'Karnataka',
  'Kerala',
  'Madhya Pradesh',
  'Maharashtra',
  'Manipur',
  'Meghalaya',
  'Mizoram',
  'Nagaland',
  'Odisha',
  'Punjab',
  'Rajasthan',
  'Sikkim',
  'Tamil Nadu',
  'Telangana',
  'Tripura',
  'Uttar Pradesh',
  'Uttarakhand',
  'West Bengal',
];

// variable for storing the selected state
dynamic selectedState;


// init state function calling the getUserData
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  String specificUrl = "http://192.168.0.243:8097/manageUser/getUser?userId=USR20230420100343328";

  


// function for fetching specific user data
  Future<void> getUserData() async {
    try {
      var data = await GetMethod.getRequest(specificUrl);

    if (data != null) {
      setState(() {
        firstNameController.text = data['userFirstName'] ?? '';
        lastNameController.text = data['userLastName'] ?? '';
        dateOfBirthController.text = data['userDateOfBirth'] ?? '';
        emailController.text = data['userEmail'] ?? '';
        addressController.text = data['userAddress'] ?? '';
        pincodeController.text = data['userPincode'] ?? '';
        cityController.text = data['userCity'] ?? '';
        selectedGender = data['userGender'] ?? '';
        selectedState = data['userState'] ?? '';


      });
    }
    } catch (e) {
      print("the error is: $e");
    }
  }

// function for adding the date format
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      DateFormat formatter = DateFormat(
          'yyyy-MM-dd'); // You can change the format as per your requirement
      final String dateOfBirth = formatter.format(picked).toString();
      // print(dateOfBirth);
      setState(() {
        dateOfBirthController.text =
            dateOfBirth; // You can format this as per your requirement
      });
    }
  }

// function for updating the specific user data
  Future updateUserDetails() async {

    try {
      var response = await PutMethod.putRequest(
        "http://192.168.0.243:8097/manageUser/updateUser?userId=","USR20230420100343328",
        jsonEncode({
          'userFirstName': firstNameController.text,
          'userLastName': lastNameController.text,
          'userDateOfBirth': dateOfBirthController.text,
          'userEmail': emailController.text,
          'userAddress': addressController.text,
          'userPincode': pincodeController.text,
          'userCity': cityController.text,
          'userGender': selectedGender,
          'userState' : selectedState,

          

          

        })
        );


        (response==200)? 
        Fluttertoast.showToast(
          msg: " Data updated successfully",
          // msg: "Successfully Created",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0) : 

        Fluttertoast.showToast(
          msg: " Updation failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

    RedisConnection.set('firstName', firstNameController.text);
    RedisConnection.set('lastName', lastNameController.text);
    RedisConnection.set('emailId', emailController.text);

    } catch (e) {
      print("the error is: $e");
    }

  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){

        // used to handle the onFocus() activities
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                              prefixIcon: Icon(Icons.person),
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
                              prefixIcon: Icon(Icons.person),
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
                          onTap: () => selectDate(context),
                          decoration: const InputDecoration(
                              label: Text("Date of Birth"),
                              prefixIcon: Icon(Icons.calendar_month),
                              border: OutlineInputBorder()),
                          controller: dateOfBirthController,
                        ),
                      ),
                    ),
    
                    // container for gender section
                    Expanded(
                      child: DropdownButtonFormField(
                        value: selectedGender, // Set the currently selected value in the dropdown
                        items: genderList.map((e) {
                          return DropdownMenuItem(value: e, child: Text(e));
                        }).toList(), // Set the list of items to display in the dropdown
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value as String; // Update the currently selected value in the dropdown
                                          
                            // print(
                            //     "the value of genderSelected is: $selectedGender");
                          });
                        },
                        decoration: const InputDecoration(
                          label: Text("Gender"),
                          border: OutlineInputBorder()
                        ),
                      ),
                    ),
                  ],
                ),
    
                // container for Email section
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    cursorColor: Colors.green,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        label: Text("Email"), 
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                    ),
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
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(Get.width* 0.03),
                          child: const FaIcon(FontAwesomeIcons.addressBook),
                        ),
                        label: const Text("Address"), border: const OutlineInputBorder()),
                    controller: addressController,
                  ),
                ),
    
    
                // contianer for pincode and city
                Row(
                  children: [

                    // container for city
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          cursorColor: Colors.green,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(Get.width* 0.03),
                                child: const FaIcon(FontAwesomeIcons.city),
                              ),
                              label: const Text("City"), 
                              border: const OutlineInputBorder()),
                          controller: cityController,
                        ),
                      ),
                    ),

                    // container for pincode
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          cursorColor: Colors.green,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(Get.width* 0.03),
                                child: const Icon(Icons.numbers),
                              ),
                              label: const Text("Pincode"),
                              border: const OutlineInputBorder()),
                          controller: pincodeController,
                        ),
                      ),
                    ),
    
                    
                  ],
                ),



                // container for state section
                Padding(
  padding: const EdgeInsets.all(15.0),
  child: DropdownButtonFormField(
    value: selectedState, // Set the currently selected value in the dropdown
    items: statesIndia.map((e) {
      return DropdownMenuItem(value: e, child: Text(e));
    }).toList(), // Set the list of items to display in the dropdown
    onChanged: (value) {
      setState(() {
        selectedState = value as String; // Update the currently selected value in the dropdown
        cityController.text = ''; // Clear the city field when the state changes
      });
    },
    decoration: const InputDecoration(
      label: Text("State"),
      border: OutlineInputBorder()
    ),
  ),
),


              ],
            ),
          ),
        ),
    
        // update button
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            updateUserDetails();
            Navigator.pop(context);
            Navigator.pop(context);
            // Navigator.popUntil(context, ModalRoute.withName('/MyProfilePage'));
            // Navigator.push(
            //   context, 
            //   MaterialPageRoute(builder: (context)=> MyProfilePage(userId: widget.userId))
            // );
          },
          label: const Text("Update"),
        ),
      ),
    );
  }
}


              