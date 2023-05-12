import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:vcharge/models/stationModel.dart';
import 'package:vcharge/services/getMethod.dart';
import 'package:vcharge/utils/availabilityColorFunction.dart';
import 'package:vcharge/view/homeScreen/widgets/bgMap.dart';
import 'dart:math' as Math;

import '../../../stationsSpecificDetails/stationsSpecificDetails.dart';

class SearchingWidget extends SearchDelegate {
  SearchingWidget(this.userId);

  List<dynamic> userToStationDistanceList = [];

  LatLng? userPosition = BgMapState.userLocation;

  // ignore: prefer_typing_uninitialized_variables
  final userId;

  Future<List<dynamic>> fetchData(String keyword) async {
    if (keyword.length < 2) return [];

    final url =
        "http://192.168.0.243:8096/manageStation/getStationsByKeyword?query=$keyword";
    final response = await GetMethod.getRequest(url);
    return response;
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
  List<dynamic> getDistanceList(stationList) {
    // await getLocationOfUser();
    return stationList.map((station) {
      return getDistanceFromUser(userPosition!,
          LatLng(station['stationLatitude'], station['stationLongitude']));
    }).toList();
  }

  //this function sort the stations on the basis of distance and store the result in sortedStationList
  List<dynamic> getSortStationList(stationList) {
    var userToStationDistanceList = getDistanceList(stationList);

    // Combine the station and distance lists into a list of Map objects
    var sortedStationDistanceList = List.generate(
      stationList.length,
      (index) => {
        'station': stationList[index],
        'distance': userToStationDistanceList[index]
      },
    );

    // Sort the stationDistanceList based on the distance value in each Map object
    sortedStationDistanceList
        .sort((a, b) => a['distance'].compareTo(b['distance']));
    return sortedStationDistanceList;
    // print(sortedStationDistanceList);

    // var sortedStationList;
    // var sortedDistanceList;

    // Extract the sorted station names into a new list
    // for (int i = 0; i < sortedStationDistanceList.length; i++) {
    //   sortedStationList.add(sortedStationDistanceList[i]['station']);
    //   sortedDistanceList.add(sortedStationDistanceList[i]['distance']);
    // }
  }

// variable for storing the keyword user entered
  String? selectedQuery;

// var for storing the result of searching
  dynamic result;

// list of stations came after the search results
  List<RequiredStationDetailsModel> stationsData = [];

// this method is used to display the right side of the search or say the clear button
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

// this method is used to display the left hand side widgets or say the arrow back method
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

// this method is used when we tap the search button
  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchData(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          final data = snapshot.data!;
          final sortedData = getSortStationList(data);
          if (sortedData.isNotEmpty) {
            return SizedBox(
              child: data.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric( horizontal: Get.width * 0.01),
                          child: const Divider(
                            height: 1,
                            thickness: 0.2,
                          ),
                        );
                      },
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          StationsSpecificDetails(
                                            stationId: sortedData[index]
                                                ['station']['stationId'],
                                            userId: userId,
                                          )));
                            },
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.ev_station, size: Get.height * 0.05,color: Colors.green,),
                              ],
                            ),
                            title: Text(
                              sortedData[index]['station']['stationName'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width *
                                          0.04),
                            ),
                            subtitle: //container for station address
                                Text(
                              sortedData[index]['station']['stationArea'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: //column for 'distance from user' and connector type
                                Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                Wrap(
                                  spacing:
                                      MediaQuery.of(context).size.width *
                                          0.02,
                                  children: [
                                    //text for distance
                                    data[index] == null
                                        ? const CircularProgressIndicator()
                                        : Text(
                                            '${sortedData[index]['distance'].toStringAsFixed(2)} KM',
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
                                              sortedData[index]['station']
                                                  ['stationStatus']!),
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
                            ));
                      }),
            );
          } else if (query.length < 2) {
            return const Center(
              child: Text("Search Results..."),
            );
          } else {
            return const Center(child: Text("No results"));
          }
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error fetching results."));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

// this button is used to display the suggestions
  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchData(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          final data = snapshot.data!;
          if (data.isNotEmpty) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return ListTile(
                  title: Text(item["stationName"]),
                  subtitle: Text(item["stationArea"]),
                  leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.ev_station, size: Get.height * 0.05,color: Colors.green,),
                              ],
                            ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StationsSpecificDetails(
                                userId: userId, stationId: item['stationId'])));
                  },
                );
              },
            );
          } else if (query.length < 2) {
            return const Center(
              child: Text("Search Results..."),
            );
          } else {
            return const Center(child: Text("No results"));
          }
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error fetching results."));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

/*

// this button is used to display the suggestions
  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchData(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          final data = snapshot.data!;
          if (data.isNotEmpty) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return ListTile(
                  title: Text(item["stationName"]),
                  subtitle: Text(item["stationArea"]),
                  leading: const Icon(Icons.location_city),
                  onTap: () {
                    // Navigator.pop(context);

                    // StaticVariablesForMap.mapController.move(LatLng(double.parse(item['stationLatitude']), double.parse(
                    //           item['stationLongitude'],
                    //         )), 17);

                    print("the listtile on tap function is called");

                    showResults(context);



                    // Marker(
                    //     point: LatLng(
                    //         double.parse(item['stationLatitude']),
                    //         double.parse(
                    //           item['stationLongitude'],
                    //         )),
                    //     builder: (ctx) => GestureDetector(  
                    //           onTap: () {
                                
                    //             Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (context) =>
                    //                         StationsSpecificDetails(
                    //                           stationId: item['stationId'],
                    //                           userId: 'userId',
                    //                         )));

                    //             print("outside the on tap of the marker");
                    //           },
                    //         ));
                    // showResults(context);

                    print("outside the on tap of listtile");

                    //               return Marker(
                    //   // width: 20.0,
                    //   // height: 20.0,
                    //   anchorPos:
                    //       AnchorPos.align(AnchorAlign.center), //change center to bottom
                    //   point: LatLng(double.parse(idx.stationLatitude!),
                    //       double.parse(idx.stationLongitude!)),
                    //   builder: (ctx) => GestureDetector(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => StationsSpecificDetails(
                    //                     stationId: idx.stationId!,
                    //                     userId: userId,
                    //                   )));
                    //     },
                    //     child: FaIcon(
                    //       FontAwesomeIcons.locationDot,
                    //       size: 30,
                    //       color: AvaliblityColor.getAvailablityColor(idx.stationStatus!),
                    //     ),
                    //   ),
                    // );


                    



                  },
                );
              },
            );
          } else if (query.length < 2) {
            return const Center(
              child: Text("Search Results..."),
            );
          } else {
            return const Center(child: Text("No results"));
          }
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error fetching results."));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }


*/
}
