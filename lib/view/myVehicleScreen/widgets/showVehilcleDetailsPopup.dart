import 'package:flutter/material.dart';
import 'package:vcharge/models/vehicleModel.dart';

class ShowVehicleDetailsPopup extends StatelessWidget {
  //Initialize the VehicleModel object
  final VehicleModel vehicleDetails;

  //Take the VehicleModel object as a parameter in the constructor
  const ShowVehicleDetailsPopup({super.key, required this.vehicleDetails});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //GestureDetector for back button
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child:
                const CircleAvatar(radius: 15, child: Icon(Icons.arrow_back)),
          ),

          //GestureDetector for back button
          GestureDetector(
            onTap: () {},
            child: const CircleAvatar(
                backgroundColor: Colors.red,
                radius: 15,
                child: Icon(Icons.delete)),
          ),
        ],
      ),
      content: Wrap(
        children: [
          //Container for Image
          SizedBox(
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     width: 2,
            //     color: Color.fromARGB(255, 94, 213, 98),
            //   ),
            // ),
            // width: double.infinity,
            // height: 120,
            child: Image.asset('assets/images/demoCar.png'),
          ),

          const SizedBox(
            height: 10,
            width: 1,
          ),

          //Container for Vehicle Name
          Container(
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, left: 1, right: 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //We have added expanded in text because, if text get renderFlow error, so expanded can adjust it
                const Expanded(
                  child: Text(
                    'Vehicle Name',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Expanded(
                    child: Text(
                  '${vehicleDetails.vehicleBrandName} ${vehicleDetails.vehicleModelName}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                ))
              ],
            ),
          ),

          //Container for Vehicle Resistartion Number
          Container(
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, left: 1, right: 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                //We have added expanded in text because, if text get renderFlow error, so expanded can adjust it
                Expanded(
                  child: Text(
                    'Registration No.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Expanded(
                    child: Text(
                  'MH12AC1234',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                ))
              ],
            ),
          ),

          //Container for Battery Capacity
          Container(
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, left: 1, right: 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //We have added expanded in text because, if text get renderFlow error, so expanded can adjust it
                const Expanded(
                  child: Text(
                    'Battery Capacity',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Expanded(
                    child: Text(
                  '${vehicleDetails.vehicleBatteryCapacity}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.end,
                ))
              ],
            ),
          ),

          //Container for Battery Capacity
          Container(
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, left: 1, right: 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //We have added expanded in text because, if text get renderFlow error, so expanded can adjust it
                const Expanded(
                  child: Text(
                    'Connector Type',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Expanded(
                    child: Text(
                  '${vehicleDetails.vehicleAdaptorType}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                ))
              ],
            ),
          ),

          const SizedBox(
            width: 1,
            height: 10,
          ),
        ],
      ),
    );
  }
}
