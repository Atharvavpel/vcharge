import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

    //this function takes a parameter string as availiblityStatus, and returns a color based on availablity
    MaterialColor getAvailablityColor(String availiblityStatus){
      if(availiblityStatus == 'Available'){
        return Colors.green;
      }
      else if(availiblityStatus == 'NotAvailable'){
        return Colors.red;
      }
      else{
        return Colors.orange;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.stationModel.stationName}"),
      ),
      body: ListView.builder(
          itemCount: chargerList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
              child: Card(
                elevation: 4.0,
                child: ExpansionTile(
                  leading: CircleAvatar(backgroundColor: getAvailablityColor(chargerList[index]['chargerStatus']), radius: 7,),
                  title: Text(chargerList[index]['chargerName'], style: const TextStyle(fontWeight: FontWeight.bold),),
                  children: [
                    Container(
                      margin: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          //container for location
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(7)),
                              margin: const EdgeInsets.all(5),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, bottom: 1, top: 1),
                                child: Row(children: [
                                  const Icon(Icons.location_on_rounded),
                                  Text(
                                      "${widget.stationModel.stationLocation}"),
                                ]),
                              )),

                          //container for phone number
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              margin: const EdgeInsets.all(5),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, bottom: 1, top: 1),
                                child: Row(children: [
                                  const Icon(Icons.phone),
                                  Text(
                                      "${widget.stationModel.stationContactNumber}"),
                                ]),
                              )),

                          //Container for charger type and charger availiblity type
                          Container(
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //Container for charger type
                                Container(
                                  width: 110,
                                  height: 80,
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10, left: 4, right: 4),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text('Charger Type'),
                                        const Divider(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          thickness: 2,
                                          indent: 20,
                                          endIndent: 20,
                                        ),
                                        Text(chargerList[index]
                                            ['chargerType'])
                                      ],
                                    ),
                                  ),
                                ),

                                //container for availiblity type
                                Container(
                                  width: 110,
                                  height: 80,
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10, left: 4, right: 4),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text('Availability'),
                                        const Divider(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          thickness: 2,
                                          indent: 20,
                                          endIndent: 20,
                                        ),
                                        Text(
                                            chargerList[index]['chargerStatus'])
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          //Container for cost and chargerId
                          Container(
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //Container for cost
                                Container(
                                  width: 110,
                                  height: 80,
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.shade300,
                                    ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10, left: 4, right: 4),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text('Cost'),
                                        const Divider(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          thickness: 2,
                                          indent: 20,
                                          endIndent: 20,
                                        ),
                                        Text(
                                            '${chargerList[index]['chargerCostPerKWH']}/kWh')
                                      ],
                                    ),
                                  ),
                                ),

                                // const VerticalDivider(
                                //   color: Colors. black,
                                //   thickness: 2,
                                //   indent: 20,
                                //   endIndent: 20,
                                // ),

                                //Container for charger Id
                                Container(
                                  width: 110,
                                  height: 80,
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.shade300,
                                    ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10, left: 4, right: 4),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text('ChargerID'),
                                        const Divider(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          thickness: 2,
                                          indent: 20,
                                          endIndent: 20,
                                        ),
                                        Text(
                                            '${chargerList[index]['chargerId']}')
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //container for connector type and support
                          Container(
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //Container for connector type
                                Container(
                                  width: 110,
                                  // height: 80,
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10, left: 4, right: 4),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text('Connector Type',textAlign: TextAlign.center,),
                                        const Divider(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          thickness: 2,
                                          indent: 20,
                                          endIndent: 20,
                                        ),
                                        Text(
                                            '${chargerList[index]['chargerConnectorType']}')
                                      ],
                                    ),
                                  ),
                                ),

                                // const VerticalDivider(
                                //   color: Colors. black,
                                //   thickness: 2,
                                //   indent: 20,
                                //   endIndent: 20,
                                // ),

                                //Container for support
                                Container(
                                  // width: 110,
                                  // height: 80,
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10, left: 4, right: 4),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text('Support'),
                                        IconButton(
                                          onPressed: (){}, 
                                          icon: Icon(Icons.support_agent, size: 40,)
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        
                          Container(
                            width: 220,
                            child: ElevatedButton(
                              onPressed: (){},
                              child: Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: FaIcon(FontAwesomeIcons.bookmark),
                                  ),
                                  Text('Book Charging Session',style: TextStyle(fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                ),
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
