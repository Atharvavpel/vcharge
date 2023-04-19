import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:vcharge/models/stationModel.dart';
import 'package:vcharge/services/getLiveLocation.dart';
import 'package:vcharge/services/getMethod.dart';
import 'dart:math' as Math;

import 'package:vcharge/view/listOfStations/widgets/searchBarOfLOS.dart';
import 'package:vcharge/view/stationsSpecificDetails/stationsSpecificDetails.dart';

class ListOfStations extends StatefulWidget {
  String userId;
  ListOfStations({required this.userId, super.key});

  @override
  State<StatefulWidget> createState() => ListOfStationsState();
}

class ListOfStationsState extends State<ListOfStations> {
  //stores current location of user
  LatLng? userPosition;

  @override
  void initState() {
    super.initState();
    // getStationList();
    sortStationList();
  }

  //this list store the list of stations
  List<StationModel> stationsList = [];

  //this list store the distance for user to each station
  List<double> userToStationDistanceList = [];

  //this list store the list of station and distance
  List<Map<String, dynamic>> sortedStationDistanceList = [];

  //this list container the list of sorted station
  List<StationModel> sortedStationList = [];

  //get current location of the user
  Future<void> getLocationOfUser() async {
    var position = await GetLiveLocation.getUserLiveLocation();
    setState(() {
      userPosition = LatLng(position.latitude, position.longitude);
    });
  }

  Future<void> getStationList() async {
    try {
      var data = await GetMethod.getRequest(
          'http://192.168.0.43:8081/vst1/manageStation/getRequiredStationsDetails');
      setState(() {
        if (data != null) {
          for (int i = 0; i < data.length; i++) {
            stationsList.add(StationModel.fromJson(data[i]));
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  //To calculate the distance between two points on the Earth's surface given their latitude and longitude coordinates, you can use the Haversine formula.
  double getDistanceFromUser(LatLng latLng1, LatLng latLng2) {
    // convert decimal degrees to radians
    double lat1 = latLng1.latitude;
    double lon1 = latLng1.longitude;
    double lat2 = latLng2.latitude;
    double lon2 = latLng2.longitude;

    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1); // deg2rad below
    var dLon = deg2rad(lon2 - lon1);
    var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(deg2rad(lat1)) *
            Math.cos(deg2rad(lat2)) *
            Math.sin(dLon / 2) *
            Math.sin(dLon / 2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    var d = R * c; // Distance in km
    return d;
  }

  double deg2rad(deg) {
    return deg * (Math.pi / 180);
  }

  //this function takes a parameter string as availiblityStatus, and returns a color based on availablity
  MaterialColor getAvailablityColor(String availiblityStatus) {
    if (availiblityStatus.toLowerCase().replaceAll(' ', '') == 'available') {
      return Colors.green;
    } else if (availiblityStatus.toLowerCase().replaceAll(' ', '') == 'unavailable') {
      return Colors.red;
    } else {
      return Colors.orange;
    }
  }

  //this function calculate distance from user to each station and store it in userToStationDistanceList
  Future<void> getDistanceList() async {
    await getStationList();
    await getLocationOfUser();

    userToStationDistanceList = stationsList.map((station) {
      return getDistanceFromUser(
          userPosition!,
          LatLng(double.parse(station.stationLatitude!),
              double.parse(station.stationLongitude!)));
    }).toList();
  }

  //this function sort the stations on the basis of distance and store the result in sortedStationList
  Future<void> sortStationList() async {
    await getDistanceList();

    // Combine the station and distance lists into a list of Map objects
    sortedStationDistanceList = List.generate(
      stationsList.length,
      (index) => {
        'station': stationsList[index],
        'distance': userToStationDistanceList[index]
      },
    );

// Sort the stationDistanceList based on the distance value in each Map object
    sortedStationDistanceList
        .sort((a, b) => a['distance'].compareTo(b['distance']));
    // print(sortedStationDistanceList);

// Extract the sorted station names into a new list
    setState(() {
      for (int i = 0; i < sortedStationDistanceList.length; i++) {
        sortedStationList.add(sortedStationDistanceList[i]['station']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('List of Stations'),
          ),
          body: SafeArea(
            child: Wrap(
              children: [
                //Container for search bar
                Container(
                    margin: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.04),
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: SearchBarofLOS(
                      userId: widget.userId,
                    )),

                //Container for List Of Station
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.73,
                  child: sortedStationList.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: sortedStationList.length,
                          itemBuilder: (context, index) {
                            return Card(
                                elevation: 4,
                                color: const Color.fromARGB(255, 243, 254, 255),
                                margin: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.02),
                                child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StationsSpecificDetails(
                                                    stationModel:
                                                        sortedStationList[
                                                            index],
                                                    userId: widget.userId,
                                                  )));
                                    },
                                    title: Text(
                                      sortedStationList[index].stationName!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04),
                                    ),
                                    subtitle: //container for station address
                                        Text(
                                      sortedStationList[index].stationLocation!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: //column for 'distance from user' and connector type
                                        Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Wrap(
                                          spacing: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                          children: [
                                            //text for distance
                                            userPosition == null
                                                ? const CircularProgressIndicator()
                                                : Text(
                                                    '${sortedStationDistanceList[index]['distance'].toStringAsFixed(2)} KM',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),

                                            //CircleAvater to show avaliblity
                                            CircleAvatar(
                                              radius: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02,
                                              backgroundColor:
                                                  getAvailablityColor(
                                                      sortedStationList[index]
                                                          .stationStatus!),
                                            ),
                                          ],
                                        ),

                                        //Container for connector type
                                        Text(
                                          sortedStationList[index]
                                              .stationPowerStandard!,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    )));
                          }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/*  ExpansionTile(
                leading: CircleAvatar(
                  backgroundColor: getAvailablityColor("Available"),
                  radius: 6,
                ),
                title: Text(
                  stationsList[index]['stationName'],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                subtitle: Text('${stationsList[index]['stationLocation']}'),
                children: [


                  //container for contact number
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(7)),
                      margin: const EdgeInsets.only(
                          top: 5, bottom: 5, right: 13, left: 13),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, bottom: 3, top: 3),
                        child: Row(children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 2, bottom: 2, left: 2, right: 15),
                            child: Icon(Icons.call),
                          ),
                          Text(
                              "${stationsList[index]['stationContactNumber']}"),
                        ]),
                      )),



                  //Container for active time and parking type
                  Container(
                    margin: const EdgeInsets.only(
                        top: 5, bottom: 5, right: 13, left: 13),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Active Time'),
                                const Divider(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  thickness: 2,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                Text(stationsList[index]['stationWorkingTime'])
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Parking Type'),
                                const Divider(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  thickness: 2,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                Text(stationsList[index]['stationParkingType'])
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),



                  //Container for amenities
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                        top: 5, bottom: 5, right: 13, left: 13),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Amenities:',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Wrap(
                          spacing: 2.0, // set the spacing between the children
                          // runSpacing:
                          //     2.0, // set the spacing between the lines
                          children: List.generate(
                              stationsList[index]['stationAmenity'] != null
                                  ? stationsList[index]['stationAmenity'].length
                                  : 0, (item) {
                            return Chip(
                              label: Text(
                                '${stationsList[index]['stationAmenity'][item]}',
                                style: const TextStyle(fontSize: 12),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ],
              );
*/