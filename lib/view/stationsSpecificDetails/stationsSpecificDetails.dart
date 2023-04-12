import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vcharge/view/stationsSpecificDetails/widgets/reservePopup.dart';
import '../../models/stationModel.dart';

class StationsSpecificDetails extends StatefulWidget {
  StationModel? stationModel;
  String userId;

  StationsSpecificDetails({required this.userId, required this.stationModel, super.key});

  @override
  State<StatefulWidget> createState() => StationsSpecificDetailsState();
}

class StationsSpecificDetailsState extends State<StationsSpecificDetails> {
  List<dynamic> chargerList = [];
  StationModel? stationModel;

  //true indicates Amenity button is selected and false indicated Review button
  bool selectedButton = true;

  @override
  void initState() {
    super.initState();
    stationModel = widget.stationModel;
    chargerList = widget.stationModel!.chargers!;
  }

  //this function takes a parameter string as availiblityStatus, and returns a color based on availablity
  MaterialColor getAvailablityColor(String availiblityStatus) {
    if (availiblityStatus == 'Available') {
      return Colors.green;
    } else if (availiblityStatus == 'NotAvailable') {
      return Colors.red;
    } else {
      return Colors.orange;
    }
  }

  IconData getIconForAmenity(String amenity) {
    if (amenity.replaceAll(" ", "").toLowerCase() == 'restrooms') {
      return Icons.hotel;
    } else if (amenity.toLowerCase().replaceAll(" ", "") == 'loungearea') {
      return Icons.local_cafe;
    } else if (amenity.toLowerCase().replaceAll(" ", "") == 'foodservice') {
      return Icons.restaurant;
    } else if (amenity.replaceAll(" ", "").toLowerCase() == 'shops') {
      return Icons.shopping_bag;
    } else {
      return Icons.abc;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Station"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Container for station heading and share button
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.05,
                left: MediaQuery.of(context).size.width * 0.06,
                right: MediaQuery.of(context).size.width * 0.06,
                bottom: MediaQuery.of(context).size.width * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Expanded for station name
                  Expanded(
                      flex: 6,
                      child: Text(
                        stationModel!.stationName!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.06),
                      )),

                  //Expanded for share Icon
                  Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.share,
                            size: MediaQuery.of(context).size.width * 0.07,
                          )))
                ],
              ),
            ),

            //Container for station address
            Container(
              child: Row(
                children: [
                  //container for location Icon
                  Container(
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.directions)),
                  ),
                  //conteinr for station address text
                  Expanded(
                    child: Container(
                      child: Text(
                        stationModel!.stationLocation!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Container for station phone number
            Container(
              child: Row(
                children: [
                  //container for call Icon
                  Container(
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.call)),
                  ),
                  //conteiner for station contact number text
                  Container(
                    child: Text(
                      stationModel!.stationContactNumber!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Container for add to favorite
            Container(
              child: Row(
                children: [
                  //container for favorite Icon
                  Container(
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.favorite)),
                  ),
                  //container for add to favorite text
                  Container(
                    child: const Text(
                      'Add to Favorite',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Container for station active time
            Container(
              child: Row(
                children: [
                  //container for watch icon
                  Container(
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.watch_later)),
                  ),
                  //container for station active time text
                  Container(
                    child: Text(
                      stationModel!.stationWorkingTime!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Container for Amenity and review button
            Container(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Row container 2 button for amineties and review
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedButton
                                ? Colors.green
                                : Colors.white, // Set the button color
                          ),
                          onPressed: () {
                            setState(() {
                              selectedButton = true;
                            });
                          },
                          child: Text('Amenities',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: selectedButton
                                      ? Colors.white
                                      : Colors.black))),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedButton
                                ? Colors.white
                                : Colors.green, // Set the button color
                          ),
                          onPressed: () {
                            setState(() {
                              selectedButton = false;
                            });
                          },
                          child: Text(
                            'Reviews',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: selectedButton
                                    ? Colors.black
                                    : Colors.white),
                          )),
                    ],
                  ),
              
                  //This container consist of 2 container for amenities and review
                  Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: AnimatedSwitcher(
                      switchInCurve: Curves.easeInOut,
                      switchOutCurve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 500),
                      child: selectedButton
                          ?
                          //Container for Amenities
                          Container(
                              alignment: Alignment.center,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      stationModel!.stationAmenity!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.all(
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                      child: Column(
                                        children: [
                                          //Amenity icon
                                          Icon(
                                            getIconForAmenity(stationModel!
                                                .stationAmenity![index]),
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.06,
                                            color: Colors.green,
                                          ),
                                          //Amenity text
                                          Text(
                                            stationModel!
                                                .stationAmenity![index],
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            )
                          :
                          
                          //Container for reviews
                          Container(
                              alignment: Alignment.center,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      stationModel!.stationAmenity!.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.green.shade100,
                                              child: const Icon(Icons.person),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.01),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  const Text(
                                                    'Anyone name',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    'Dummy Text, for demo perpose, written for no reason. Please Ignore this',
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                    ),
                  ),
                ],
              ),
            ),

            //Container for Charger List
            Container(
              child: Column(
                children: [
                  //Container for chargers heading
                  Container(
                    margin: const EdgeInsets.only(left: 2, right: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: const Color.fromARGB(255, 151, 202, 96),
                            width: 2)),
                    width: double.maxFinite,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Chargers',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 151, 202, 96),
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.045),
                      ),
                    ),
                  ),

                  //Container for charger list
                  Container(
                    height: MediaQuery.of(context).size.height * 0.34,
                    child: ListView.builder(
                        itemCount: stationModel!.chargers!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.015),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: const Color.fromARGB(255, 239, 255, 255),
                            child: ExpansionTile(
                              //leading
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //card to show availability as a circular avatar
                                  Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            MediaQuery.of(context).size.width *
                                                0.06)),
                                    child: CircleAvatar(
                                      backgroundColor:
                                          getAvailablityColor('Available'),
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                    ),
                                  ),
                                ],
                              ),
                              //title - name of charger
                              title: Text(
                                stationModel!.chargers![index].chargerName!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              //subtitle
                              subtitle: Text(
                                  "Number of connectors: ${stationModel!.chargers![index].chargerNumberOfConnector}"),
                              //children
                              children: [
                                //Row for reserve button and scan to charge button
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //button for reserve
                                    ElevatedButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(
                                                          15.0)),
                                            ),
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (BuildContext context) =>
                                                ReservePopUp(
                                              stationName:
                                                  stationModel!.stationName!,
                                              stationLocation: stationModel!
                                                  .stationLocation!,
                                              chargerModel: stationModel!
                                                  .chargers![index], userId: widget.userId, stationId: stationModel!.stationId!,
                                            ),
                                          );
                                        },
                                        child: const Text('Reserve')),
                                    //button for scan to reserve
                                    ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('Scan to Charge')),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
