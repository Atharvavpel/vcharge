import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:vcharge/main.dart';
import 'package:vcharge/models/stationModel.dart';
import 'package:vcharge/services/getMethod.dart'; 
import 'package:latlong2/latlong.dart';
import 'package:vcharge/view/homeScreen/widgets/bgMap.dart';

import '../../../stationsSpecificDetails/stationsSpecificDetails.dart';

class SearchingWidget extends SearchDelegate {
  Future<List<dynamic>> fetchData(String keyword) async {
    if (keyword.length < 2) return [];

    final url =
        "http://192.168.0.43:8081/vst1/manageStation/search?query=$keyword";
    final response = await GetMethod.getRequest(url);
    return response;
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
          if (data.isNotEmpty) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return Column(
                  children: [
                    Text(item['stationName']),
                    Text(item['stationId']),
                    Text(item['stationLatitude']),
                    Text(item['stationLongitude']),
                    Text(item['stationStatus']),
                    Text(item['stationArea']),
                    const Divider(height: 10,),
                  ],
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
}
