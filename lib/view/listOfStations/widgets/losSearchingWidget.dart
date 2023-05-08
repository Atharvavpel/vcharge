import 'package:flutter/material.dart';
import 'package:vcharge/services/getMethod.dart';

class losSearchingWidget extends SearchDelegate{




  Future<List<dynamic>> fetchData(String keyword) async {
    if (keyword.length < 2) return [];

    final url =
        "http://192.168.0.243:8096/vst1/manageStation/search?query=$keyword";
    final response = await GetMethod.getRequest(url);
    return response;
  }

// storing the query entered by the user
  String? selectedQuery;

// storing the result after the seraching process
  dynamic result;

// function for displaying the clear button in searchbar
  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(
      onPressed: (){}, 
      icon: const Icon(Icons.clear)
    )
    ];
  }

// function for displaying the back button in searchbar
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){}, 
      icon: const Icon(Icons.arrow_back)
    );
  }

// function for displaying the searching results
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


  
// function for displaying the suggestions as the user begins to enter the keyword in searchbar
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