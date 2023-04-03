import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vcharge/view/homeScreen/homeScreen.dart';

class FilterPopUp extends StatefulWidget {
  String userId;

  FilterPopUp({required this.userId,super.key});

  @override
  State<StatefulWidget> createState() => FilterPopUpState();
}

class FilterPopUpState extends State<FilterPopUp> {
  //variables for DropDown menu for vehicle selection
  var vehicleList = ['Tata Nexon', 'Tata Tiago', 'Mahindra XUV400'];
  // ignore: prefer_typing_uninitialized_variables
  var vehicleSelected;

  //variable for "show available toggle button"
  var availableToggleButton = false;

  //variables for access type
  bool isPublicSelected = false;
  bool isPrivateSelected = false;

  // Variable for Connector Type
  var connectors = ["CSS 2", "Type 2", "Type 1", "GBT"];
  late List<bool> selectedConnector;

  @override
  void initState() {
    super.initState();
    selectedConnector = List.filled(connectors.length, false);
  }

  @override
  Widget build(BuildContext context) {
    // print("Inside the filter method");

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Card(
        child: Container(
          margin: const EdgeInsets.all(2),
          child: Wrap(
            children: [
              //Following statck include cross button and title
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 130, 199, 85),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      //Title
                      const Text(
                        'Filter',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
          
                      //Cross Button
                      Positioned(
                          top: 5,
                          right: 8,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen()));
                                },
                                child: const FaIcon(
                                  FontAwesomeIcons.x,
                                  size: 18,
                                  color: Color.fromARGB(255, 252, 252, 252),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
          
              //Folowing id the container for all the other assets
              Container(
                height: 500,
                child: Column(
                  children: [
                    //DropDown menu for vehicle selection
                    Container(
                        width: double.maxFinite,
                        color: const Color.fromARGB(40, 131, 199, 85),
                        child: const Padding(
                          padding: EdgeInsets.all(6),
                          child: Text(
                            'Vehicle',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        )),
                    Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 255, 255, 255)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          value:
                              vehicleSelected, // Set the currently selected value in the dropdown
                          items: vehicleList.map((e) {
                            return DropdownMenuItem(value: e, child: Text(e));
                          }).toList(), // Set the list of items to display in the dropdown
                          hint: const Text(
                              "No vehicle selected"), // Set the hint text to display when no value is selected
                          onChanged: (value) {
                            setState(() {
                              vehicleSelected =
                                  value; // Update the currently selected value in the dropdown
                            });
                          },
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          isExpanded:
                              true, // expand the dropdown button to full width
                          isDense: true, // reduces the height of the button
                        ),
                      ),
                    ),
          
                    //Container for "show available chargers only" section
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Row(children: [
                          const Text(
                            'Show Available Charger Only',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          Switch(
                            value: availableToggleButton,
                            onChanged: (newValue) {
                              setState(() {
                                availableToggleButton = newValue;
                              });
                            },
                            activeTrackColor:
                                const Color.fromARGB(255, 144, 228, 66),
                            activeColor: const Color.fromARGB(255, 244, 244, 244),
                          )
                        ]),
                      ),
                    ),
          
                    //Container for "Access Type"
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //heding text
                          Container(
                              width: double.maxFinite,
                              color: const Color.fromARGB(40, 131, 199, 85),
                              child: const Padding(
                                padding: EdgeInsets.all(6),
                                child: Text(
                                  'Access type',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(spacing: 10, children: [
                              GestureDetector(
                                child: Chip(
                                  label: Text(
                                    'Public',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: isPublicSelected
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  backgroundColor: isPublicSelected
                                      ? Colors.green
                                      : const Color.fromARGB(40, 131, 199, 85),
                                ),
                                onTap: () {
                                  isPublicSelected = !isPublicSelected;
                                  setState(() {});
                                },
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              GestureDetector(
                                child: Chip(
                                  label: Text(
                                    'Private',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: isPrivateSelected
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  backgroundColor: isPrivateSelected
                                      ? Colors.green
                                      : const Color.fromARGB(40, 131, 199, 85),
                                ),
                                onTap: () {
                                  isPrivateSelected = !isPrivateSelected;
                                  setState(() {});
                                },
                              )
                            ]),
                          )
                        ],
                      ),
                    ),
          
                    //Container for Connector Type
                    Container(
                        width: double.maxFinite,
                        color: const Color.fromARGB(40, 131, 199, 85),
                        child: const Padding(
                          padding: EdgeInsets.all(6),
                          child: Text(
                            'Connector Type',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        )),
                    const SizedBox(
                      width: 1,
                      height: 3,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: connectors.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(
                                right: 15, left: 15, top: 3, bottom: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                width: 1,
                                color: const Color.fromARGB(255, 130, 199, 85),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8, left: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(connectors[index]),
                                  Checkbox(
                                    value: selectedConnector[index],
                                    onChanged: (value) {
                                      setState(() {
                                        selectedConnector[index] = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
          
              //Container for the Apply button and reset button
              Container(
                margin: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                          Fluttertoast.showToast(
                            msg: "Filters Applied Successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.black,
                            fontSize: 16.0,
                          );
                        },
                        child: const Text('Apply')),
                    ElevatedButton(onPressed: () {}, child: const Text('Reset')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
