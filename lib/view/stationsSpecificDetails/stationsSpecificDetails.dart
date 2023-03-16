import 'package:flutter/material.dart';
import '../../models/stationModel.dart';

class StationsSpecificDetails extends StatefulWidget {
  StationModel stationModel;
  @override
  State<StatefulWidget> createState() => StationsSpecificDetailsState();

  StationsSpecificDetails(this.stationModel);
}

class StationsSpecificDetailsState extends State<StationsSpecificDetails> {
  List<dynamic> chargerList = [];

  @override
  void initState() {
    super.initState();
    chargerList = widget.stationModel.stationChargerList ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.stationModel.stationName}"),
      ),
      body: ListView.builder(
          itemCount: chargerList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(left: 3, right: 3, top: 5,bottom: 5),
              child: ExpansionTile(
                leading: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: chargerList[index]['chargerStatus']=='Available' ? Colors.green : Colors.red,
                  ),
                ),
                title: Text(chargerList[index]['chargerName']),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Cherger Type'),
                        Text('${chargerList[index]['chargerType']}'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Charger Connector Type'),
                        Text('${chargerList[index]['chargerConnectorType']}'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Charger Status'),
                        Text('${chargerList[index]['chargerStatus']}'),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}




// class OnPressStation extends StatefulWidget{
//   StationModel stationModel;
//   @override
//   State<StatefulWidget> createState() => OnPressStationState();
//   OnPressStation(this.stationModel);
// }
// class OnPressStationState extends State<OnPressStation>{
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text("${widget.stationModel.stationName}"),
//       actions: [
//         Container(
//           margin: const EdgeInsets.all(15.0),
//           child: Column(
//             children: [
//               //container for location
//               Container(
//                   decoration: BoxDecoration(
//                       color: Colors.grey.shade400,
//                       borderRadius: BorderRadius.circular(7)),
//                   margin: const EdgeInsets.all(5),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 5, right: 5, bottom: 1, top: 1),
//                     child: Row(children: [
//                       const Icon(Icons.location_on_rounded),
//                       Text("${widget.stationModel.stationLocation}"),
//                     ]),
//                   )),

//               //container for phone number
//               Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade400,
//                     borderRadius: BorderRadius.circular(7),
//                   ),
//                   margin: const EdgeInsets.all(5),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 5, right: 5, bottom: 1, top: 1),
//                     child: Row(children: [
//                       const Icon(Icons.phone),
//                       Text("${widget.stationModel.stationContactNumber}"),
//                     ]),
//                   )),

//               Container(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     //Container for charger type
//                     Container(
//                       width: 110,
//                       height: 80,
//                       margin: const EdgeInsets.only(
//                         top: 10,
//                         bottom: 10,
//                       ),
//                       decoration: BoxDecoration(
//                           color: Colors.grey.shade400,
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 10, bottom: 10, left: 4, right: 4),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             Text('Charger Type'),
//                             Divider(
//                               color: Color.fromARGB(255, 0, 0, 0),
//                               thickness: 2,
//                               indent: 20,
//                               endIndent: 20,
//                             ),
//                             Text('Level 1 Charger')
//                           ],
//                         ),
//                       ),
//                     ),
                    
//                     //container for availiblity type
//                     Container(
//                       width: 110,
//                       height: 80,
//                       margin: const EdgeInsets.only(
//                         top: 10,
//                         bottom: 10,
//                       ),
//                       decoration: BoxDecoration(
//                           color: Colors.grey.shade400,
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 10, bottom: 10, left: 4, right: 4),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             Text('Availability'),
//                             Divider(
//                               color: Color.fromARGB(255, 0, 0, 0),
//                               thickness: 2,
//                               indent: 20,
//                               endIndent: 20,
//                             ),
//                             Text('Busy')
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         )
//       ],
//     );
//   }

// }

// class OnPressCharger extends StatefulWidget {
//   StationModel stationModel;
//   @override
//   State<StatefulWidget> createState() => OnPressChargerState();

//   OnPressCharger(this.stationModel);
// }

// class OnPressChargerState extends State<OnPressCharger> {
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text("${widget.stationModel.stationName}"),
//       actions: [
//         Container(
//           margin: const EdgeInsets.all(15.0),
//           child: Column(
//             children: [
//               //container for location
//               Container(
//                   decoration: BoxDecoration(
//                       color: Colors.grey.shade400,
//                       borderRadius: BorderRadius.circular(7)),
//                   margin: const EdgeInsets.all(5),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 5, right: 5, bottom: 1, top: 1),
//                     child: Row(children: [
//                       const Icon(Icons.location_on_rounded),
//                       Text("${widget.stationModel.stationLocation}"),
//                     ]),
//                   )),

//               //container for phone number
//               Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade400,
//                     borderRadius: BorderRadius.circular(7),
//                   ),
//                   margin: const EdgeInsets.all(5),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 5, right: 5, bottom: 1, top: 1),
//                     child: Row(children: [
//                       const Icon(Icons.phone),
//                       Text("${widget.stationModel.stationContactNumber}"),
//                     ]),
//                   )),

//               Container(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     //Container for charger type
//                     Container(
//                       width: 110,
//                       height: 80,
//                       margin: const EdgeInsets.only(
//                         top: 10,
//                         bottom: 10,
//                       ),
//                       decoration: BoxDecoration(
//                           color: Colors.grey.shade400,
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 10, bottom: 10, left: 4, right: 4),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             Text('Charger Type'),
//                             Divider(
//                               color: Color.fromARGB(255, 0, 0, 0),
//                               thickness: 2,
//                               indent: 20,
//                               endIndent: 20,
//                             ),
//                             Text('Level 1 Charger')
//                           ],
//                         ),
//                       ),
//                     ),
                    
//                     //container for availiblity type
//                     Container(
//                       width: 110,
//                       height: 80,
//                       margin: const EdgeInsets.only(
//                         top: 10,
//                         bottom: 10,
//                       ),
//                       decoration: BoxDecoration(
//                           color: Colors.grey.shade400,
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 10, bottom: 10, left: 4, right: 4),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             Text('Availability'),
//                             Divider(
//                               color: Color.fromARGB(255, 0, 0, 0),
//                               thickness: 2,
//                               indent: 20,
//                               endIndent: 20,
//                             ),
//                             Text('Busy')
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
