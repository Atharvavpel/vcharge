import 'package:flutter/material.dart';
import 'package:vcharge/services/GetMethod.dart';
import 'package:vcharge/view/addVehicleScreen/addVehicle.dart';
import 'package:vcharge/view/myVehicleScreen/widgets/showVehilcleDetailsPopup.dart';

import '../../models/vehicleModel.dart';

// ignore: must_be_immutable
class MyVehicleScreen extends StatefulWidget {
  String userId;
  MyVehicleScreen({required this.userId, super.key});

  @override
  State<StatefulWidget> createState() => MyVehicleScreenState();
}

class MyVehicleScreenState extends State<MyVehicleScreen> {
  //this list stores the list of vehicleModel objects
  // List<VehicleModel> vehicleList = [];

  //Initializing the list manually for demo purpose
  List<VehicleModel> vehicleList = [];

  @override
  void initState() {
    super.initState();
    getVehicleData();
  }

  Future<void> getVehicleData() async {
    try {
      var data = await GetMethod.getRequest(
          'http://192.168.0.243:8097/manageUser/getVehicle?userId=${widget.userId}');
      setState(() {
        if (data != null) {
          vehicleList.clear();
          for (int i = 0; i < data.length; i++) {
            vehicleList.add(VehicleModel.fromJson(data[i]));
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Vehicle'),
      ),
      body: vehicleList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
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
                                // Container(
                                //   margin:
                                //       const EdgeInsets.only(top: 3, bottom: 5),
                                //   child: const Text(
                                //     'Car Nick Name',
                                //     style: TextStyle(
                                //         fontSize: 18,
                                //         fontWeight: FontWeight.w700),
                                //   ),
                                // ),

                                //Container for car model name
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 3, bottom: 3),
                                  child: Text(
                                    '${vehicleList[index].vehicleBrandName} ${vehicleList[index].vehicleModelName}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),

                                //Container for vehicle Registration No.
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 3, bottom: 3),
                                  child: Text(
                                    '${vehicleList[index].vehicleRegistrationNo}',
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

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddVehicleScreen(userId: widget.userId,))).then((value){
                    setState(() {
                      getVehicleData();
                    });
                  });
        },
        child: const Text(
          'Add Vehicle',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
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
