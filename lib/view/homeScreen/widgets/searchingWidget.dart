import 'package:flutter/material.dart';
import 'package:vcharge/services/getMethod.dart';

class SearchingWidget extends SearchDelegate{


Future<List<dynamic>> fetchData(String keyword) async {

  if(keyword.length < 2) return [];

  final url = "http://192.168.0.43:8081/vst1/manageStation/search?query=$keyword";
  final response = await GetMethod.getRequest(url);
  return response;
  
}


String? selectedQuery;
dynamic result;

// this method is used to display the right side of the search

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (){
          query = '';
        }, 
        icon: const Icon(Icons.clear)
      )
    ];
  }

// this method is used to display the left hand side widgets 

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){
        close(context, null);
      }, 
      icon: const Icon(Icons.arrow_back)
    );
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
                  Text(item['stationId']),
                  Text(item['stationLatitude']),
                  Text(item['stationLongitude']),
                  Text(item['stationStatus']),
                ],
              );
            },
          );
        } else {
          return const Center(child: Text("No results found."));
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
                subtitle: Text(item["stationLocation"]),
                leading: const Icon(Icons.location_city),

                onTap: () {
                  selectedQuery = item["stationName"];
                  showResults(context);
                  // print("the suggestion is tapped");
                },

              );
            },
          );
        } else {
          return const Center(child: Text("No results found."));
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


