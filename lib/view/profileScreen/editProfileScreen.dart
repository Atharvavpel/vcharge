import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vcharge/services/GetMethod.dart';
import 'package:vcharge/services/putMethod.dart';
import 'package:vcharge/view/settingScreen/settingPage.dart';


class EditProfileScreen extends StatefulWidget {
  String userId;
  EditProfileScreen({super.key, required this.userId});

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
dynamic selectedState;


  @override
  void initState() {
    super.initState();
    getUserData();
  }



// function for fetching specific user data
  Future<void> getUserData() async {
    var data = await GetMethod.getRequest(
        "http://192.168.0.41:8081/manageUser/user?userId=USR20230410143236933");

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


        print("the value of genderSelected is in initsate is: $selectedGender");
        print("the value of genderSelected is in initsate is: $selectedState");
      });
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
      print(dateOfBirth);
      setState(() {
        dateOfBirthController.text =
            dateOfBirth; // You can format this as per your requirement
      });
    }
  }

// function for updating the specific user data
  Future updateUserDetails() async {
    var response = await PutMethod.putRequest(
        "http://192.168.0.41:8081/manageUser/user?userId=",
        "USR20230410143236933",
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
        }));

    print("Success");
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
                                          
                            print(
                                "the value of genderSelected is: $selectedGender");
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
                    decoration: const InputDecoration(
                        label: Text("Address"), border: OutlineInputBorder()),
                    controller: addressController,
                  ),
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
                                          
                            print(
                                "the value of selectedState is: $selectedState");
                          });
                        },
                        decoration: const InputDecoration(
                          label: Text("State"),
                          border: OutlineInputBorder()
                        ),



 















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
                          decoration: const InputDecoration(
                              label: Text("City"), border: OutlineInputBorder()),
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
                          decoration: const InputDecoration(
                              label: Text("Pincode"),
                              border: OutlineInputBorder()),
                          controller: pincodeController,
                        ),
                      ),
                    ),
    
                    
                  ],
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingPage(userId: widget.userId)));
          },
          label: const Text("Update"),
        ),
      ),
    );
  }
}
