import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:vcharge/models/stationModel.dart';
import 'package:vcharge/services/getLiveLocation.dart';
import 'package:vcharge/services/getMethod.dart';
import 'package:vcharge/utils/availabilityColorFunction.dart';
import 'package:vcharge/view/homeScreen/widgets/bgMap.dart';
import 'dart:math' as Math;

import 'package:vcharge/view/listOfStations/widgets/searchBarOfLOS.dart';
import 'package:vcharge/view/stationsSpecificDetails/stationsSpecificDetails.dart';

// ignore: must_be_immutable
class ListOfStations extends StatefulWidget {
  String userId;

  ListOfStations({required this.userId, super.key});

  @override
  State<StatefulWidget> createState() => ListOfStationsState();
}

class ListOfStationsState extends State<ListOfStations> {
  //stores current location of user
  LatLng? userPosition;

  String getStationUrl =
      'http://192.168.0.243:8096/manageStation/getStationInterface';

  @override
  void initState() {
    super.initState();
    // getStationList();
    getLocationOfUser();
    // userPosition = LatLng(
    //     BgMapState.userLocation!.latitude, BgMapState.userLocation!.longitude);
    if (mounted) {
      sortStationList();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  //this list store the list of stations
  List<RequiredStationDetailsModel> stationsList = [];

  //this list store the distance for user to each station
  List<double> userToStationDistanceList = [];

  //this list store the list of station and distance
  static List<Map<String, dynamic>> sortedStationDistanceList = [];

  //this list container the list of sorted station
  static List<RequiredStationDetailsModel> sortedStationList = [];

  //this list container the list of sorted distance according to station
  static List<double> sortedDistanceList = [];

  //get current location of the user
  Future<void> getLocationOfUser() async {
    try {
      userPosition = LatLng(BgMapState.userLocation!.latitude,
          BgMapState.userLocation!.longitude);
    } catch (e) {
      var position = await GetLiveLocation.getUserLiveLocation();
      if (mounted) {
        setState(() {
          userPosition = LatLng(position.latitude, position.longitude);
        });
      }
    }
  }

  Future<void> getStationList(String url) async {
    try {
      var data = await GetMethod.getRequest(url);
      if (data.isNotEmpty) {
        // print('Data Not Empty');
        stationsList.clear();
        for (int i = 0; i < data.length; i++) {
          stationsList.add(RequiredStationDetailsModel.fromJson(data[i]));
        }
        if (mounted) {
          setState(() {
            BgMapState.getMarkersDetails(context, stationsList);
          });
        }
      } else {
        print("Empty Data");
      }
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

  //this function calculate distance from user to each station and store it in userToStationDistanceList
  Future<void> getDistanceList() async {
    await getStationList(getStationUrl);
    // await getLocationOfUser();

    userToStationDistanceList = stationsList.map((station) {
      return getDistanceFromUser(userPosition!,
          LatLng(station.stationLatitude!, station.stationLongitude!));
    }).toList();
  }

  //this function sort the stations on the basis of distance and store the result in sortedStationList
  Future<void> sortStationList() async {
    stationsList.clear();
    userToStationDistanceList.clear();
    sortedStationDistanceList.clear();
    sortedStationList.clear();
    sortedDistanceList.clear();

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
    if (mounted) {
      setState(() {
        for (int i = 0; i < sortedStationDistanceList.length; i++) {
          sortedStationList.add(sortedStationDistanceList[i]['station']);
          sortedDistanceList.add(sortedStationDistanceList[i]['distance']);
        }
        // print(sortedStationList);
      });
    }
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
                                                    stationId:
                                                        sortedStationList[index]
                                                            .stationId!,
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
                                      sortedStationList[index].stationArea!,
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
                                            sortedDistanceList[index] == null
                                                ? const CircularProgressIndicator()
                                                : Text(
                                                    '${sortedDistanceList[index].toStringAsFixed(2)} KM',
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
                                              backgroundColor: AvaliblityColor
                                                  .getAvailablityColor(
                                                      sortedStationList[index]
                                                          .stationStatus!),
                                            ),
                                          ],
                                        ),

                                        //Container for connector type
                                        // Text(
                                        //   sortedStationList[index]
                                        //       .stationPowerStandard!,
                                        //   style: const TextStyle(
                                        //     color: Colors.grey,
                                        //     fontWeight: FontWeight.bold,
                                        //   ),
                                        // )
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
