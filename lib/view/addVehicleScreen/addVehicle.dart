import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:vcharge/models/vehicleModel.dart';
import 'package:vcharge/services/PostMethod.dart';

class AddVehicleScreen extends StatefulWidget {
  String userId;

  AddVehicleScreen({required this.userId, super.key});

  @override
  State<StatefulWidget> createState() => AddVehicleScreenState();
}

class AddVehicleScreenState extends State<AddVehicleScreen> {
  final formKey = GlobalKey<FormState>();

  var vehicleTypeList = ['two', 'three', 'four'];
  // ignore: prefer_typing_uninitialized_variables
  var selectedVehicleType;
  var vehicleTypeSelectBool = [false, false, false];

  // ignore: prefer_typing_uninitialized_variables
  var selectedManufacturer;
  // ignore: prefer_typing_uninitialized_variables
  var selectedCarModel;

  bool vehicleTypeValidator = false;

// this is the list for manufacturers
  var manufacturarList = ['Tata', 'Tesla', 'Hundai', 'Kia', "BMW"];

  String regNoError = '';

// this is the list for the car models
  var carModelList = [
    'Nexon',
    'Model S',
    'Tiago',
    'Tigor',
    'Model X',
    'BMW i4 M20'
  ];

// variable for taking registration number
  var regNoController = TextEditingController();

// variable for the nick-name input field
  var nickNameController = TextEditingController();

  Future<bool> addVehicle() async {
    // Fetch the data from the form input fields
    String brandName = selectedManufacturer;
    String modelName = selectedCarModel;
    String vehicleType = vehicleTypeList[selectedVehicleType];
    String vehicleRegistrationNo = regNoController.text;
    String vehicleNickName = nickNameController.text;

    // Create a new VehicleModel object with the fetched data
    VehicleModel newVehicle = VehicleModel(
        vehicleType: vehicleType,
        vehicleBrandName: brandName,
        vehicleModelName: modelName,
        vehicleRegistrationNo: vehicleRegistrationNo,
        vehicleNickName: vehicleNickName,
        vehicleBatteryType: "li-ion",
        vehicleBatteryCapacity: "32.4kwh",
        vehicleRange: "000",
        vehicleMotorType: "magnet",
        vehicleMotorPower: "129ps",
        vehicleChargingStandard: "css2",
        vehicleAdaptorType: "ccs2",
        vehicleClass: "Suv");

    try {
      // Convert the newVehicle object to JSON
      Map<String, dynamic> vehicleJson = newVehicle.toJson();

      // Send the JSON data as a POST request
      String url =
          'http://192.168.0.243:8097/manageUser/addVehicles?userId=${widget.userId}';

      final response = await PostMethod.postRequestMod(
          url,
          jsonEncode({
            "vehicleType": vehicleType,
            "vehicleBrandName": brandName,
            "vehicleModelName": modelName,
            "vehicleRegistrationNo": vehicleRegistrationNo,
            "vehicleNickName": vehicleNickName,
            "vehicleBatteryType": "li-ion",
            "vehicleBatteryCapacity": "32.4kwh",
            "vehicleRange": "000",
            "vehicleMotorType": "magnet",
            "vehicleMotorPower": "129ps",
            "vehicleChargingStandard": "css2",
            "vehicleAdaptorType": "ccs2",
            "vehicleClass": "Suv"
          }));

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: " vechicle added successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        return true;
      }
      if (response.statusCode == 400) {
        setState(() {
          regNoError = jsonDecode(response.body)['vehicleRegistrationNo'];
        });
        Fluttertoast.showToast(
            msg: "Failed to add",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      print("Error in vehicle addition: $e");
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Vehicle'),
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Heading Text
                  const Center(
                    child: Text(
                      'Vehicle Details',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),

                  //select list for vehicle type
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // vehicle type heading
                      const Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          'Vehicle Type',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //check box for two wheeler
                          Row(
                            children: [
                              Radio(
                                  groupValue: selectedVehicleType,
                                  value: 0,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedVehicleType = value;
                                    });
                                  }),
                              const Icon(
                                Icons.electric_moped_rounded,
                                color: Colors.green,
                              ),
                            ],
                          ),

                          //check box for four wheeler
                          Row(
                            children: [
                              Radio(
                                  groupValue: selectedVehicleType,
                                  value: 1,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedVehicleType = value;
                                    });
                                  }),
                              const Icon(
                                Icons.electric_car,
                                color: Colors.green,
                              )
                            ],
                          ),

                          //check box for three wheeler
                          Row(
                            children: [
                              Radio(
                                  groupValue: selectedVehicleType,
                                  value: 2,
                                  onChanged: (value) {
                                    setState(() {
                                      vehicleTypeValidator = false;
                                      selectedVehicleType = value;
                                    });
                                  }),
                              const Icon(
                                Icons.electric_rickshaw,
                                color: Colors.green,
                              )
                            ],
                          ),
                        ],
                      ),

                      // validation widget
                      Visibility(
                        visible: vehicleTypeValidator,
                        child: const Text('Please select vehicle type', style: TextStyle(color: Colors.red),),
                      )
                    ],
                  ),

                  const SizedBox(
                    width: 1,
                    height: 15,
                  ),

                  //heading text of vehicle name
                  const Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      'Vehicle Name',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(
                    width: 1,
                    height: 5,
                  ),

                  //Drop down menu to select manufacturer
                  Card(
                    elevation: 5.0,
                    color: const Color.fromARGB(255, 243, 255, 255),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
                        value:
                            selectedManufacturer, // Set the currently selected value in the dropdown
                        items: manufacturarList.map((e) {
                          return DropdownMenuItem(value: e, child: Text(e));
                        }).toList(), // Set the list of items to display in the dropdown
                        hint: const Text(
                            "Select Manufacturer"), // Set the hint text to display when no value is selected
                        onChanged: (value) {
                          setState(() {
                            selectedManufacturer =
                                value; // Update the currently selected value in the dropdown
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a value';
                          }
                          return null;
                        },

                        isExpanded:
                            true, // expand the dropdown button to full width
                        isDense: true, // reduces the height of the button
                      ),
                    ),
                  ),

                  //Drop down menu to select car model
                  Card(
                    elevation: 5,
                    color: const Color.fromARGB(255, 243, 254, 255),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
                        value:
                            selectedCarModel, // Set the currently selected value in the dropdown
                        items: carModelList.map((e) {
                          return DropdownMenuItem(value: e, child: Text(e));
                        }).toList(), // Set the list of items to display in the dropdown
                        hint: const Text(
                            "Select Car Model"), // Set the hint text to display when no value is selected
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a value';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            selectedCarModel =
                                value; // Update the currently selected value in the dropdown
                          });
                        },

                        isExpanded:
                            true, // expand the dropdown button to full width
                        isDense: true, // reduces the height of the button
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 1,
                    height: 15,
                  ),

                  //Heading text of registration number
                  const Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      'Registration Number',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(
                    width: 1,
                    height: 5,
                  ),

                  //Text Field for enter registration number
                  Card(
                    elevation: 5,
                    color: const Color.fromARGB(255, 243, 254, 255),
                    child: TextFormField(
                      controller: regNoController,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                          hintText: 'Eg: MH12AE1234',
                          hintStyle: const TextStyle(color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          errorText: regNoError.isEmpty ? null : regNoError,
                          border: InputBorder.none),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter vehicle registration number';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(
                    width: 1,
                    height: 15,
                  ),

                  // //heading of nick name
                  // const Padding(
                  //   padding: EdgeInsets.only(left: 8, right: 8),
                  //   child: Text(
                  //     'Nick Name',
                  //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  // //Text field for nick name
                  // Card(
                  //   elevation: 5,
                  //   color: Color.fromARGB(255, 243, 254, 255),
                  //   child: TextField(
                  //     controller: nickNameController,
                  //     style: TextStyle(fontSize: 16),
                  //     decoration: const InputDecoration(
                  //         hintText: 'Enter Nick Name',
                  //         hintStyle: TextStyle(color: Colors.grey),
                  //         contentPadding: EdgeInsets.symmetric(
                  //             vertical: 10.0, horizontal: 10.0),
                  //         border: InputBorder.none),
                  //   ),
                  // ),

                  const SizedBox(
                    height: 15,
                    width: 1,
                  ),

                  //heading for more details
                  const Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      'More Details',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),

                  //card for more details
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: const Color.fromARGB(255, 243, 254, 255),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          //row for vehicle name
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Vehicle Name',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              Expanded(
                                  child: Card(
                                elevation: 3,
                                child: Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Text(
                                    "${selectedManufacturer ?? '--'} ${selectedCarModel  ??'--'}",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ))
                            ],
                          ),

                          //row for connector type
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Expanded(
                                  child: Text(
                                'Connector type',
                                style: TextStyle(fontSize: 15),
                              )),
                              Expanded(
                                  child: Card(
                                elevation: 3,
                                child: Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Text(
                                    '--',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ))
                            ],
                          ),

                          //row for Battery Capacity
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Expanded(
                                  child: Text(
                                'Battery Capacity',
                                style: TextStyle(fontSize: 15),
                              )),
                              Expanded(
                                  child: Card(
                                elevation: 3,
                                child: Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Text(
                                    '--',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // floating action button for adding vehicle
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if(selectedVehicleType !=null){
              setState(() {
                vehicleTypeValidator = false;
              });
            }
            if (selectedVehicleType == null) {
              setState(() {
                vehicleTypeValidator = true;
              });
            } else if (formKey.currentState!.validate()) {
              if (await addVehicle()) {
                Navigator.of(context).pop();
              }
            }
          },
          label: const Text(
            'Add Vehicle',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ));
  }
}
