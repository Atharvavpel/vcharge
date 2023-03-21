import 'package:flutter/material.dart';

import '../../models/vehicleModel.dart';

class MyVehicleScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyVehicleScreenState();
}

class MyVehicleScreenState extends State<MyVehicleScreen>{
  //this list stores the list of vehicleModel objects
  List<VehicleModel> vehicleList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Vehicle'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Row(
              children: [
                const Text('Car Image'),

                Column(
                  children: [
                    
                  ],
                ),
              ],
            ),
          );
        }
        
      ),
    );
  }

}