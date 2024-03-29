import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vcharge/models/chargerModel.dart';
import 'package:vcharge/services/DeleteMethod.dart';
import 'package:vcharge/services/GetMethod.dart';
import 'package:vcharge/services/PostMethod.dart';
import 'package:vcharge/view/chargingScreen/chargingScreen.dart';
import 'package:vcharge/view/homeScreen/widgets/bgMap.dart';
import 'package:vcharge/view/stationsSpecificDetails/widgets/reservePopup.dart';
import '../../models/feedback_model.dart';
import '../../models/stationModel.dart';
import 'package:vcharge/view/stationsSpecificDetails/widgets/review_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class StationsSpecificDetails extends StatefulWidget {
  String stationId;
  String userId;

  StationsSpecificDetails(
      {required this.userId, required this.stationId, super.key});

  @override
  State<StatefulWidget> createState() => StationsSpecificDetailsState();
}

class StationsSpecificDetailsState extends State<StationsSpecificDetails> {
  List<ChargerModel> chargerList = [];
  String? stationId;
  String? feedbackStationId;
  int userRating = 0;
  String? feedbackId;
  List<FeedbackModel> feedbackList = [];

  StationModel? stationDetails;

  bool selectedButton = true;

  bool isFavourite = false;

  List<bool> isOpenList = [];

  @override
  void initState() {
    super.initState();
    stationId = widget.stationId;
    feedbackStationId = widget.stationId;
    getStationDetails();
    getChargerList();
    checkFavourite();
    _loadUserRating();
  }

  void toggleExpansionTile(int index) {
    setState(() {
      for (int i = 0; i < isOpenList.length; i++) {
        if (i == index) {
          isOpenList[i] = !isOpenList[i];
        } else {
          isOpenList[i] = false;
        }
      }
    });
  }

  Future<List<FeedbackModel>> fetchFeedback() async {
    final apiUrl = Uri.parse(
        'http://192.168.0.243:8094/manageFeedback/getFeedbackByStationId?feedbackStationId=${widget.stationId}');

    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      final List<FeedbackModel> feedbackList =
          jsonList.map((json) => FeedbackModel.fromJson(json)).toList();
      return feedbackList;
    } else {
      throw Exception('Failed to load feedback');
    }
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

  Future<void> getChargerList() async {
    try {
      var data = await GetMethod.getRequest(
          'http://192.168.0.243:8096/manageCharger/getChargers?stationId=$stationId');
      if (data != null) {
        setState(() {
          for (int i = 0; i < data.length; i++) {
            chargerList.add(ChargerModel.fromJson(data[i]));
          }
          isOpenList.clear();
          isOpenList = List.generate(data.length, (index) => false);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _loadUserRating() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int storedRating = prefs.getInt('userRating') ?? 0;
    setState(() {
      userRating = storedRating;
    });
  }

  //this function takes a parameter string as availiblityStatus, and returns a color based on availablity
  MaterialColor getAvailablityColor(String availiblityStatus) {
    if (availiblityStatus.toLowerCase() == 'available') {
      return Colors.green;
    } else if (availiblityStatus.toLowerCase() == 'unavailable') {
      return Colors.red;
    } else {
      return Colors.orange;
    }
  }

  IconData getIconForAmenity(String amenity) {
    if (amenity.replaceAll(" ", "").toLowerCase() == 'restaurants' ||
        amenity.replaceAll(" ", "").toLowerCase() == 'restaurants') {
      return Icons.hotel;
    } else if (amenity.toLowerCase().replaceAll(" ", "") == 'local_cafe') {
      return Icons.local_cafe;
    } else if (amenity.toLowerCase().replaceAll(" ", "") == 'snackarea') {
      return Icons.restaurant;
    } else if (amenity.replaceAll(" ", "").toLowerCase() == 'shops') {
      return Icons.shopping_bag;
    } else if (amenity.replaceAll(" ", "").toLowerCase() == 'wifi') {
      return Icons.wifi;
    } else if (amenity.replaceAll(" ", "").toLowerCase() == 'restaurant') {
      return Icons.restaurant;
    } else if (amenity.replaceAll(" ", "").toLowerCase() == 'telephone') {
      return Icons.call;
    } else if (amenity.replaceAll(" ", "").toLowerCase() ==
            'evaccessorystore' ||
        amenity.replaceAll(" ", "").toLowerCase() == 'evaccessarystore') {
      return Icons.store;
    } else if (amenity.replaceAll(" ", "").toLowerCase() == 'garden') {
      return Icons.park_outlined;
    } else {
      return Icons.abc;
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> openGoogleMaps(String url) async {
    try {
      if (await launchUrl(url as Uri)) {
        await launchUrl(url as Uri);
      } else {
        throw 'Could not open Google Maps';
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> checkFavourite() async {
    try {
      var data = await GetMethod.getRequest(
          'http://192.168.0.243:8097/manageUser/getFavorites?userId=${widget.userId}');
      if (data != null) {
        for (int i = 0; i < data.length; i++) {
          if (widget.stationId == data[i]['stationId']) {
            setState(() {
              isFavourite = true;
            });
            break;
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  //function to launch map with the direction
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Station"),
        ),
        body: stationDetails == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Container for station heading and share button
                  Expanded(
                    flex: 7,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.06,
                        vertical: MediaQuery.of(context).size.width * 0.03,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Expanded for station name
                          Expanded(
                              flex: 6,
                              child: Text(
                                stationDetails!.stationName!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05),
                              )),

                          //Expanded for share Icon
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                  onPressed: () {
                                    Share.share(
                                        'Check out this EV charging station');
                                  },
                                  icon: Icon(
                                    Icons.share,
                                    size: MediaQuery.of(context).size.width *
                                        0.05,
                                  )))
                        ],
                      ),
                    ),
                  ),

                  //Container for address, ph. number, add to favoriate, active time
                  Expanded(
                    flex: 16,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.06,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Container for station address
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                launchMapsDirections(
                                    stationDetails!.stationLatitude!,
                                    stationDetails!.stationLongitude!,
                                    BgMapState.userLocation!.latitude,
                                    BgMapState.userLocation!.longitude);
                              },
                              child: Row(
                                children: [
                                  //container for location Icon
                                  const Expanded(
                                    flex: 2,
                                    child: Icon(Icons.directions),
                                  ),
                                  //container for station address text
                                  Expanded(
                                    flex: 14,
                                    child: Text(
                                      stationDetails!.stationArea!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //Container for station phone number
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _makePhoneCall(
                                    'tel: ${stationDetails!.stationContactNumber}');
                              },
                              child: Row(
                                children: [
                                  //container for call Icon
                                  const Expanded(
                                      flex: 2, child: Icon(Icons.call)),
                                  //conteiner for station contact number
                                  Expanded(
                                    flex: 14,
                                    child: Text(
                                      stationDetails!.stationContactNumber!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //Container for add to favorite
                          Expanded(
                            child: Row(
                              children: [
                                //container for favorite Icon
                                Expanded(
                                  flex: 2,
                                  child: IconButton(
                                      onPressed: () async {
                                        setState(() {
                                          if (isFavourite) {
                                            DeleteMethod.deleteRequest(
                                                'http://192.168.0.243:8097/manageUser/removeFavorite?userId=${widget.userId}&stationId=${widget.stationId}');
                                            isFavourite = false;
                                          } else {
                                            PostMethod.postRequest(
                                                'http://192.168.0.243:8097/manageUser/addFavorites?userId=${widget.userId}',
                                                jsonEncode({
                                                  "stationId":
                                                      stationDetails!.stationId,
                                                  "stationName": stationDetails!
                                                      .stationName,
                                                  "stationCity": stationDetails!
                                                      .stationCity,
                                                  "stationStatus":
                                                      stationDetails!
                                                          .stationStatus
                                                }));
                                            isFavourite = true;
                                          }
                                        });
                                      },
                                      icon: Icon(
                                        Icons.favorite,
                                        color: isFavourite
                                            ? Colors.red
                                            : Colors.black,
                                      )),
                                ),
                                //container for add to favorite text
                                const Expanded(
                                  flex: 14,
                                  child: Text(
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
                          //Container for station active time and star rating
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //container for watch icon
                                const Expanded(
                                  flex: 2,
                                  child: Icon(Icons.watch_later),
                                ),
                                //container for station active time text
                                Expanded(
                                  flex: 8,
                                  child: Text(
                                    '${stationDetails!.stationOpeningTime} - ${stationDetails!.stationClosingTime}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                Expanded(
                                  flex: 5,
                                  child: Row(
                                    children: List.generate(5, (index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ReviewForm(
                                                      stationId: stationId,
                                                    )),
                                          );
                                        },
                                        child: Icon(
                                          size: 20,
                                          Icons.star,
                                          color: userRating >= index + 1
                                              ? Colors.orange
                                              : Colors.grey,
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //Container for Amenity and review button
                  Expanded(
                    flex: 16,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Row container 2 button for amineties and review

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedButton = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: selectedButton
                                      ? Colors.green
                                      : Colors.transparent,
                                ),
                                child: Text(
                                  'Amenities',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: selectedButton
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final feedbackList =
                                    await fetchFeedback(); // Call the fetchFeedback function
                                setState(() {
                                  selectedButton = false;
                                  this.feedbackList =
                                      feedbackList; // Store the fetched feedback data
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: selectedButton
                                      ? Colors.transparent
                                      : Colors.green,
                                ),
                                child: Text(
                                  'Reviews',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: selectedButton
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        //This container consist of 2 container for amenities and review
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: AnimatedSwitcher(
                              switchInCurve: Curves.easeInOut,
                              switchOutCurve: Curves.easeInOut,
                              duration: const Duration(milliseconds: 500),
                              child: selectedButton
                                  ?
                                  //Container for Amenities
                                  Container(
                                      margin: const EdgeInsets.only(left: 11),
                                      alignment: Alignment.center,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: stationDetails!
                                              .stationAmenity!.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.01),
                                              child: Column(
                                                children: [
                                                  //Amenity icon
                                                  Icon(
                                                    getIconForAmenity(
                                                        stationDetails!
                                                                .stationAmenity![
                                                            index]),
                                                    size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.06,
                                                    color: Colors.green,
                                                  ),
                                                  //Amenity text
                                                  Text(
                                                    stationDetails!
                                                        .stationAmenity![index],
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
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
                                        itemCount: feedbackList.length,
                                        itemBuilder: (context, index) {
                                          final feedback = feedbackList[index];
                                          // Assuming feedbackRating is a String containing the user's rating as a number (e.g., '4')
                                          final userRating = int.tryParse(
                                                  feedback.feedbackRating ??
                                                      '0') ??
                                              0;

                                          return SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.65,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.green.shade100,
                                                    child: const Icon(
                                                        Icons.person),
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              feedback.createBy ??
                                                                  'Unknown User',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(width: 10),
                                                            for (int i = 1;
                                                                i <= 5;
                                                                i++)
                                                              Icon(
                                                                Icons.star,
                                                                size: 15.0,
                                                                color: i <=
                                                                        userRating
                                                                    ? Colors
                                                                        .orange
                                                                    : Colors
                                                                        .grey,
                                                              ),
                                                          ],
                                                        ),
                                                        // Display the review text
                                                        Text(
                                                          feedback.feedbackText ??
                                                              'No feedback available',
                                                          style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.03,
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),

                  //Container for Charger List
                  Expanded(
                    flex: 45,
                    child: Column(
                      children: [
                        //Container for chargers heading
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 151, 202, 96),
                                    width: 2)),
                            width: double.maxFinite,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Chargers',
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 151, 202, 96),
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.045),
                              ),
                            ),
                          ),
                        ),

                        //Container for charger list
                        Expanded(
                          flex: 23,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),

                            // height: MediaQuery.of(context).size.height * 0.4,
                            child: chargerList.isEmpty
                                ? Center(
                                    child: Text(
                                      'No charger to show',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.08,
                                          color: Colors.grey),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: chargerList.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        margin: EdgeInsets.all(
                                            MediaQuery.of(context).size.width *
                                                0.015),
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        color: const Color.fromARGB(
                                            255, 246, 249, 252),
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                              dividerColor: Colors.transparent),
                                          child: ExpansionTile(
                                            onExpansionChanged: (isExpanded) {
                                              toggleExpansionTile(index);
                                            },
                                            initiallyExpanded:
                                                isOpenList[index],
                                            //title - name of charger
                                            title: Text(
                                              chargerList[index].chargerName!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),

                                            //subtitle
                                            subtitle: Text(
                                                "Connectors: ${chargerList[index].chargerNumberOfConnector}"),

                                            //children
                                            children: [
                                              // column to show connectors
                                              Column(
                                                children: [
                                                  Text(
                                                    'Connectors',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            Get.width * 0.047),
                                                  ),
                                                  chargerList[index]
                                                                  .connectors ==
                                                              null ||
                                                          chargerList[index]
                                                              .connectors!
                                                              .isEmpty
                                                      ? Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  Get.height *
                                                                      0.02),
                                                          child: const Text(
                                                            'No Connector',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        )
                                                      : ListView.separated(
                                                          shrinkWrap: true,
                                                          separatorBuilder:
                                                              (context, index) {
                                                            return Divider(
                                                              color: Colors.grey
                                                                  .shade100,
                                                              thickness: 1,
                                                              height: 1,
                                                            );
                                                          },
                                                          itemCount:
                                                              chargerList[index]
                                                                  .connectors!
                                                                  .length,
                                                          itemBuilder: (context,
                                                              connector) {
                                                            return ExpansionTile(
                                                              //Row for connector type and socket
                                                              title:
                                                                  SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      '${chargerList[index].connectors![connector].connectorType!}, ',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              Get.width * 0.042),
                                                                    ),
                                                                    Text(
                                                                      '${chargerList[index].connectors![connector].connectorSocket}',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              Get.width * 0.042),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            50),
                                                                    Container(
                                                                      height:
                                                                          40,
                                                                      width:
                                                                          100,
                                                                      child:
                                                                          Card(
                                                                        color: Colors
                                                                            .white,
                                                                        elevation:
                                                                            3,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.0),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(8.0), // Adjust padding as needed
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                getAvailablityColor(chargerList[index].connectors![connector].connectorStatus!) == Colors.green ? "Available" : "Unavailable",
                                                                                style: const TextStyle(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 11,
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 8,
                                                                              ),
                                                                              CircleAvatar(
                                                                                backgroundColor: getAvailablityColor(
                                                                                  chargerList[index].connectors![connector].connectorStatus!,
                                                                                ),
                                                                                radius: 5,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),

                                                              //Row for cost and o/p power
                                                              subtitle: Row(
                                                                children: [
                                                                  //Row for cost
                                                                  Row(
                                                                    children: [
                                                                      const Text(
                                                                        'Cost: ',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.grey),
                                                                      ),
                                                                      Text(
                                                                        chargerList[index].connectors![connector].connectorCharges !=
                                                                                null
                                                                            ? chargerList[index].connectors![connector].connectorCharges!.toStringAsFixed(2) // Format as a string with 2 decimal places
                                                                            : 'N/A', // Handle the case where connectorCharges is null
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const Text(
                                                                      ' '),
                                                                  //Row for o/p power
                                                                  Row(
                                                                    children: [
                                                                      const Text(
                                                                        'O/P Power: ',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.grey),
                                                                      ),
                                                                      Text(
                                                                        '${chargerList[index].connectors![connector].connectorOutputPower}',
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),

                                                              //children for reserve and charge button
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    //button for reserve
                                                                    ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          showModalBottomSheet(
                                                                            shape:
                                                                                const RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                                                                            ),
                                                                            isScrollControlled:
                                                                                true,
                                                                            context:
                                                                                context,
                                                                            builder: (BuildContext context) =>
                                                                                ReservePopUp(
                                                                              stationName: stationDetails!.stationName!,
                                                                              stationLocation: stationDetails!.stationArea!,
                                                                              chargerModel: chargerList[index],
                                                                              userId: widget.userId,
                                                                              stationId: stationDetails!.stationId!,
                                                                              stationHostId: stationDetails!.stationHostId!,
                                                                              stationVendorId: stationDetails!.stationVendorId!,
                                                                              connectorSocket: chargerList[index].connectors![connector].connectorSocket!,
                                                                              connecterId: chargerList[index].connectors![connector].connectorId!,
                                                                            ),
                                                                          );
                                                                        },
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              Colors.orange, // Set the button color to orange
                                                                        ),
                                                                        child: const Text(
                                                                            'Reserve')),
                                                                    //button for charge
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) => ChargingScreen(
                                                                                      stationLocation: stationDetails!.stationArea!,
                                                                                      stationName: stationDetails!.stationName!,
                                                                                      userId: widget.userId,
                                                                                      chargerSerialNumber: '',
                                                                                      connectorNumber: '',
                                                                                    )));
                                                                      },
                                                                      child: const Text(
                                                                          'Charge'),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            );
                                                          })
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
