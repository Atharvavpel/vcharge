import 'package:flutter/material.dart';
import 'package:vcharge/services/GetMethod.dart';
import 'package:vcharge/view/myVehicleScreen/widgets/showVehilcleDetailsPopup.dart';

import '../../models/vehicleModel.dart';

class MyVehicleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyVehicleScreenState();
}

class MyVehicleScreenState extends State<MyVehicleScreen> {
  //this list stores the list of vehicleModel objects
  // List<VehicleModel> vehicleList = [];

  //Initializing the list manually for demo purpose
  List<VehicleModel> vehicleList = [
    VehicleModel(
        vehicleBrandName: "Tesla",
        vehicleModelName: "Model S",
        vehicleClass: "Luxury Sedan",
        vehicleColour: "Red",
        vehicleType: "Electric",
        vehicleBatteryType: "Lithium-ion",
        vehicleBatteryCapacity: "100 kWh",
        vehicleAdaptorType: "Type 2",
        vehicleTimeToChargeRegular: "8 hours",
        vehicleTimeToChargeFast: "1 hour",
        vehicleChargingStandard: "Type 2",
        vehicleRange: "412 miles",
        vehicleDriveModes: ["Sport", "Comfort", "Eco"]),
    VehicleModel(
      vehicleBrandName: "Toyota",
      vehicleModelName: "Prius",
      vehicleClass: "Compact Hatchback",
      vehicleColour: "Blue",
      vehicleType: "Hybrid",
      vehicleBatteryType: "Nickel-Metal Hydride",
      vehicleBatteryCapacity: "1.31 kWh",
      vehicleAdaptorType: "Type 1",
      vehicleTimeToChargeRegular: "2.5 hours",
      vehicleTimeToChargeFast: "N/A",
      vehicleChargingStandard: "CSS 2",
      vehicleRange: "640 miles",
      vehicleDriveModes: ["Normal", "Eco", "Power"],
    ),
    VehicleModel(
      vehicleBrandName: "Ford",
      vehicleModelName: "F-150 Lightning",
      vehicleClass: "Pickup Truck",
      vehicleColour: "White",
      vehicleType: "Electric",
      vehicleBatteryType: "Lithium-ion",
      vehicleBatteryCapacity: "115 kWh",
      vehicleAdaptorType: "CSS 2",
      vehicleTimeToChargeRegular: "10 hours",
      vehicleTimeToChargeFast: "0.5 hours",
      vehicleChargingStandard: "CSS 2",
      vehicleRange: "300 miles",
      vehicleDriveModes: ["Normal", "Sport", "Off-road"],
    ),
  ];

  @override
  void initState() {
    super.initState();
    // getVehicleData('url');
  }

  Future<void> getVehicleData(String url) async {
    var data = await GetMethod.getRequest(url);
    if (data != null) {
      vehicleList = data.map((e) {
        return VehicleModel(
            vehicleBrandName: data[e]['vehicleBrandName'],
            vehicleModelName: data[e]['vehicleModelName'],
            vehicleClass: data[e]['vehicleClass'],
            vehicleColour: data[e]['vehicleColour'],
            vehicleType: data[e]['vehicleType'],
            vehicleBatteryType: data[e]['vehicleBatteryType'],
            vehicleBatteryCapacity: data[e]['vehicleBatteryCapacity'],
            vehicleAdaptorType: data[e]['vehicleAdaptorType'],
            vehicleTimeToChargeRegular: data[e]['vehicleTimeToChargeRegular'],
            vehicleTimeToChargeFast: data[e]['vehicleTimeToChargeFast'],
            vehicleChargingStandard: data[e]['vehicleChargingStandard'],
            vehicleRange: data[e]['vehicleRange'],
            vehicleDriveModes: data[e]['vehicleDriveModes']);
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Vehicle'),
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: vehicleList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ShowVehicleDetailsPopup(
                            vehicleDetails: vehicleList[index],
                          );
                        });
                  },
                  child: Card(
                    elevation: 5,
                    color: Colors.green.shade50,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Container for Car Image
                        Expanded(
                          flex: 2,
                          child: Container(
                              margin: const EdgeInsets.all(5.0),
                              // decoration: BoxDecoration(
                              //   border: Border.all(
                              //     width: 2,
                              //     color: Color.fromARGB(255, 94, 213, 98),
                              //   ),
                              // ),
                              // width: 160,
                              // height: 160,
                              child: Image.asset('assets/images/demoCar.png')),
                        ),

                        // Container for Car Details
                        Expanded(
                          //we used expanded because the few texts was giving renderFlow error
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // text car nick name
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 3, bottom: 5),
                                  child: const Text(
                                    'Car Nick Name',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),

                                //Container for car model name
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 3, bottom: 3),
                                  child: Text(
                                    '${vehicleList[index].vehicleBrandName} ${vehicleList[index].vehicleModelName}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),

                                //Container for vehicle Registration No.
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 3, bottom: 3),
                                  child: const Text(
                                    'MH12AB9999',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),

                                //Container for vehicle adaptor type
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 3, bottom: 3),
                                  child: Text(
                                    '${vehicleList[index].vehicleAdaptorType}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),

                                //Container for vehicle battery capacity
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 3, bottom: 3),
                                  child: Text(
                                    'Battery Capacity ${vehicleList[index].vehicleBatteryCapacity}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          
          
          //Following is the code for the Add Vehicle Button
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  // color: Colors.amber,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),),
                    onPressed: () {},
                    child: const Text('Add Vehicle', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  ),
                ),
              ),
            ),
          )
        ],
      ),

      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Container(
      //     // margin: const EdgeInsets.all(10),
      //     color: Colors.amber,
      //     child: ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(20),
      //         ),
      //         fixedSize: const Size(50,20)
      //       ),
      //       onPressed: () {},
      //       child: const Text('Add Vehicle'),
      //     ),
      //   ),
      // ),
    );
  }
}
