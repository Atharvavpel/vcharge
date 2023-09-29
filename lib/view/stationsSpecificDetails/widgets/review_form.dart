import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vcharge/models/stationModel.dart';
import 'package:vcharge/services/GetMethod.dart';
import 'package:vcharge/view/homeScreen/widgets/bgMap.dart';

class ReviewForm extends StatefulWidget {
  String? stationId;

  ReviewForm({required this.stationId});

  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  int userRating = 0;
  StationModel? stationDetails; // Define your StationModel class

  @override
  void initState() {
    super.initState();
    // Fetch station details when the widget is initialized
    getStationDetails();
  }

  Future<void> getStationDetails() async {
    try {
      var data = await GetMethod.getRequest(
          'http://192.168.0.243:8096/manageStation/getStation?stationId=${widget.stationId}');
      print(widget.stationId);
      setState(() {
        stationDetails = StationModel.fromJson(data);
        print(stationDetails);
      });
    } catch (e) {
      print(e);
    }
  }

  void launchMapsDirections(
      double destinationLatitude,
      double destinationLongitude,
      double userLatitude,
      double userLongitude) async {
    // Generate the Google Maps URL
    String mapsUrl = 'https://www.google.com/maps/dir/?api=1';
    mapsUrl += '&origin=$userLatitude,$userLongitude';
    mapsUrl += '&destination=$destinationLatitude,$destinationLongitude';

    // Launch the URL in the Maps application
    if (await canLaunch(mapsUrl)) {
      await launch(mapsUrl);
    } else {
      throw 'Could not launch $mapsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate the Application'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Station Name and Address Section
          Card(
            margin: EdgeInsets.only(
                top: 16, left: 8, right: 8), // Adjust the margin as needed
            child: Column(
              children: [
                // Station Name Section
                Container(
                  padding: EdgeInsets.only(left: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Expanded for station name
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stationDetails?.stationName ?? '',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                // Station Address Section
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: InkWell(
                    onTap: () {
                      launchMapsDirections(
                        stationDetails!.stationLatitude!,
                        stationDetails!.stationLongitude!,
                        BgMapState.userLocation!.latitude,
                        BgMapState.userLocation!.longitude,
                      );
                    },
                    child: Row(
                      children: [
                        // Container for location Icon
                        const Icon(Icons.directions),
                        SizedBox(width: 10),
                        // Container for station address text
                        Expanded(
                          flex: 14,
                          child: Text(
                            stationDetails?.stationArea ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Card(
            margin: EdgeInsets.only(top: 2.0, left: 8, right: 8),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text(
                          'Your overall rating for this ?',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 1; i <= 5; i++)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    userRating = i;
                                  });
                                },
                                child: Icon(
                                  Icons.star,
                                  size: 40.0,
                                  color: i <= userRating
                                      ? Colors.orange
                                      : Colors.grey,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),
          Text(
            'Please tell people about your experience:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            maxLines: 5,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setInt('userRating', userRating);

              Navigator.pop(
                  context, userRating); // Pass the userRating as the result
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
