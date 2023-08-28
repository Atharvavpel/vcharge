import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class FilterPopUp extends StatefulWidget {
  String userId;

  FilterPopUp({required this.userId, super.key});

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

  //variables for show private chargers also
  bool privateToggleButton = false;

  // Variable for Connector Type
  var connectors = ["CCS 2", "Type 2", "Type 1", "GB/T", "CHAdeMO"];
  late List<bool> selectedConnector;

  @override
  void initState() {
    super.initState();
    selectedConnector = List.filled(connectors.length, false);
  }

  @override
  Widget build(BuildContext context) {
    // print("Inside the filter method");

    return Wrap(
      children: [
        //Following statck include cross button and title
        Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 130, 199, 85),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             const HomeScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(1.0),
                          child: FaIcon(
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
        SizedBox(
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
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
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
                    child: // Updated code with modified style
                        DropdownButton(
                      value: vehicleSelected,
                      items: vehicleList.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: TextStyle(
                              fontWeight: vehicleSelected == e
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        );
                      }).toList(),
                      hint: const Text("No vehicle selected"),
                      onChanged: (value) {
                        setState(() {
                          vehicleSelected = value;
                        });
                      },
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      isExpanded: true,
                      isDense: true,
                    )),
              ),

              //Container for "show available chargers only" section
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.03,
                    right: MediaQuery.of(context).size.width * 0.03),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                        activeColor: const Color.fromARGB(255, 244, 244, 244),
                      )
                    ]),
              ),

              //Container for "Show Private Chargers also"
              SizedBox(
                // margin: const EdgeInsets.all(5),
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.03,
                      right: MediaQuery.of(context).size.width * 0.03),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Show Private Chargers Also',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        Switch(
                          value: privateToggleButton,
                          onChanged: (newValue) {
                            setState(() {
                              privateToggleButton = newValue;
                            });
                          },
                          activeTrackColor:
                              const Color.fromARGB(255, 144, 228, 66),
                          activeColor: const Color.fromARGB(255, 244, 244, 244),
                        )
                      ]),
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
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
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
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      vehicleSelected = null;
                      availableToggleButton = false;
                      privateToggleButton = false;
                      selectedConnector = List.filled(connectors.length, false);
                    });
                  },
                  child: const Text('Reset')),
            ],
          ),
        ),
      ],
    );
  }
}
