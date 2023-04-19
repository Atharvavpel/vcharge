import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:vcharge/models/stationModel.dart';
import 'package:vcharge/services/getLiveLocation.dart';
import 'package:vcharge/services/getMethod.dart';
import 'package:vcharge/view/stationsSpecificDetails/stationsSpecificDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BgMap extends StatefulWidget {
  MapController mapController = MapController();
  String userId;

  BgMap({required this.userId, required this.mapController, super.key});

  @override
  State<StatefulWidget> createState() => BgMapState();

  //this is setter function for mapController, so that we can set mapvalue outside this dart file
  // static void setMapController(LatLng position) {
  //   BgMapState.mapController.move(position, 13);
  // }
}

class BgMapState extends State<BgMap> with TickerProviderStateMixin {
  //bool to check if location services are enabled
  // late bool serviceEnabled;

  //variable to store user data
  // late loc.LocationData locationData;

  // the user's live location data
  LatLng? userLocation;

  // map controller for accessing map properties
  MapController? mapController;

  AnimationController? animationController;

  // subscription to location updates
  // late StreamSubscription<loc.LocationData> locationSubscription;

  // list which loads the station data
  List<StationModel> stationsData = [];

  // this is the list which stores the markers related to the all stations on the map
  List<Marker> markersDetails = [];

  @override
  void initState() {
    super.initState();
    mapController = widget.mapController;
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    getStationData();
    getUserLocation();
    getLocation();
  }

  @override
  void dispose() {
    animationController?.dispose();
    // Cancel any ongoing asynchronous operation when the widget is disposed
    super.dispose();
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

// this function is used to fetch the station data and embed it into the stationsData variable
  Future<void> getStationData() async {
    try {
      var data = await GetMethod.getRequest(
          'http://192.168.0.43:8081/vst1/manageStation/stations');
      if (data != null || data.isNotEmpty) {
        // stationsData = data.map((e) => StationModel.fromJson(e)).toList();
        for (int i = 0; i < data.length; i++) {
          stationsData.add(StationModel.fromJson(data[i]));
        }
        setState(() {
          getMarkersDetails();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getMarkersDetails() async {
    markersDetails = stationsData.map((idx) {
      return Marker(
        // width: 20.0,
        // height: 20.0,
        anchorPos:
            AnchorPos.align(AnchorAlign.center), //change center to bottom
        point: LatLng(double.parse(idx.stationLatitude!),
            double.parse(idx.stationLongitude!)),
        builder: (ctx) => GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StationsSpecificDetails(
                          stationModel: idx,
                          userId: widget.userId,
                        )));
          },
          child: FaIcon(
            FontAwesomeIcons.locationDot,
            size: 30,
            color: getAvailablityColor(idx.stationStatus!),
          ),
        ),
      );
    }).toList();
  }

  //This function get the live location of the user using GetLiveLocation class
  Future<void> getLocation() async {
    var position = await GetLiveLocation.getUserLiveLocation();
    //store current location of user in local Storage such that we can fetch it
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('userLatitude', position.latitude);
    prefs.setDouble('userLongitude', position.longitude);
    if (mounted) {
      // Call the animatedMapMove method only if the widget is still mounted
      animatedMapMove(position, 15.0);
    }
  }

  //This function is use to animate the map when the mapController.move() is called
  void animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: mapController!.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapController!.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: mapController!.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    final Animation<double> animation =
        CurvedAnimation(parent: animationController!, curve: Curves.easeInOut);
// Create a TickerFuture that completes when the animation has finished.
    final animationFuture = animationController!.animateTo(1.0);

    animationController!.addListener(() {
      if (mounted) {
        setState(() {
          mapController!.move(
              LatLng(
                  latTween.evaluate(animation), lngTween.evaluate(animation)),
              zoomTween.evaluate(animation));
        });
      }
    });

    // animationFuture.whenComplete(() {
    //   // When the animation is complete, dispose of the controller.
    //   animationController!.dispose();
    // });

    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     animationController!.dispose();
    //   } else if (status == AnimationStatus.dismissed) {
    //     animationController!.dispose();
    //   }
    // });

    animationController!.forward();
  }

  //this function get User Location from shared preferences
  Future<void> getUserLocation() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getDouble('userLatitude') != null &&
        prefs.getDouble('userLongitude') != null) {
      userLocation = LatLng(
          prefs.getDouble('userLatitude')!, prefs.getDouble('userLongitude')!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
          minZoom: 5,
          maxZoom: 17.0,
          center: userLocation ?? LatLng(18.562323835185673, 73.93812780854178),
          zoom: 15.0,
          interactiveFlags: InteractiveFlag.pinchZoom |
              InteractiveFlag
                  .drag, //by this command, the map will not be able to rotate
          onPositionChanged: (mapPosition, boolValue) {
            userLocation = mapPosition.center!;
          }),
      children: [
        TileLayer(
          urlTemplate:
              'https://api.mapbox.com/styles/v1/atharva70/clf990hij00ck01pg9fcgv02h/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYXRoYXJ2YTcwIiwiYSI6ImNsZjk3cTUxZDJjc2czems3N2F3d2Y2aWUifQ._j3hKxoBC_Gnh4-qddn8lg',
          additionalOptions: const  {
            'accessToken':
                'pk.eyJ1IjoiYXRoYXJ2YTcwIiwiYSI6ImNsZjk3cTUxZDJjc2czems3N2F3d2Y2aWUifQ._j3hKxoBC_Gnh4-qddn8lg',
            'id': 'mapbox.satellite',
          },
        ),
        MarkerLayer(
          markers: [
            //user location marker
              Marker(
                point: userLocation ?? LatLng(18.562323835185673, 73.93812780854178),
                builder: (ctx) => const FaIcon(FontAwesomeIcons.locationCrosshairs),
              ),],
        ),
        MarkerClusterLayerWidget(
          options: MarkerClusterLayerOptions(
            maxClusterRadius: 45,
            size: const Size(40, 40),
            anchor: AnchorPos.align(AnchorAlign.center),
            // fitBoundsOptions property is used to configure how the map view should adjust its zoom and centering when a cluster or marker is clicked.
            fitBoundsOptions: const FitBoundsOptions(
              padding: EdgeInsets.all(50),
              maxZoom: 18,
            ),
            markers: [
              //Station markers
              for (final marker in markersDetails) marker
            ],
            builder: (context, markers) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                elevation: 5,
                color: Colors.green,
                child: Center(
                  child: Text(
                    markers.length.toString(),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/*

*/