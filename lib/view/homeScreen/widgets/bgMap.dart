import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:vcharge/models/stationModel.dart';
import 'package:vcharge/services/getLiveLocation.dart';
import 'package:vcharge/services/getMethod.dart';
import 'package:vcharge/view/stationsSpecificDetails/stationsSpecificDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BgMap extends StatefulWidget {
  MapController mapController = MapController();

  BgMap({required this.mapController, super.key});

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

  // subscription to location updates
  // late StreamSubscription<loc.LocationData> locationSubscription;

  // list which loads the station data
  List<StationModel> stationsData = [];

  // this is the list which stores the markers related to the all stations on the map
  List<Marker> markersDetails = [];

  @override
  void initState() {
    super.initState();
    getUserLocation();
    mapController = widget.mapController;
    getStationData();
    // getUserLiveLocation();
    getLocation();
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
    var data = await GetMethod.getRequest(
        'http://192.168.0.43:8081/vst1/manageStation/stations');
    if (data.isNotEmpty) {
      for (int i = 0; i < data.length; i++) {
        stationsData.add(StationModel(
          stationName: data[i]['stationName'],
          stationLocation: data[i]['stationLocation'],
          stationLatitude: data[i]['stationLatitude'],
          stationLongitude: data[i]['stationLongitude'],
          stationLocationURL: data[i]['stationLocationURL'],
          stationParkingArea: data[i]['stationParkingArea'],
          stationContactNumber: data[i]['stationContactNumber'],
          stationWorkingTime: data[i]['stationWorkingTime'],
          stationParkingType: data[i]['stationParkingType'],
          stationAmenity: data[i]['stationAmenity'],
          chargers: data[i]['chargers'],
          stationStatus: data[i]['stationStatus'],
          stationPowerStandard: data[i]['stationPowerStandard'],
        ));
      }
      setState(() {
        getMarkersDetails();
      });
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
                    builder: (context) => StationsSpecificDetails(idx)));
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

  //this is setter function for mapController, so that we can set mapvalue outside this dart file

  //This function get the live location of the user using GetLiveLocation class
  Future<void> getLocation() async {
    var position = await GetLiveLocation.getUserLiveLocation();
    //store current location of user in local Storage such that we can fetch it
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('userLatitude', position.latitude);
    prefs.setDouble('userLongitude', position.longitude);
    animatedMapMove(position, 15.0);
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
    final controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    controller.addListener(() {
      setState(() {
        mapController!.move(
            LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
            zoomTween.evaluate(animation));
      });
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
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
      layers: [
        TileLayerOptions(
          urlTemplate:
              'https://api.mapbox.com/styles/v1/atharva70/clf990hij00ck01pg9fcgv02h/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYXRoYXJ2YTcwIiwiYSI6ImNsZjk3cTUxZDJjc2czems3N2F3d2Y2aWUifQ._j3hKxoBC_Gnh4-qddn8lg',
          additionalOptions: {
            'accessToken':
                'pk.eyJ1IjoiYXRoYXJ2YTcwIiwiYSI6ImNsZjk3cTUxZDJjc2czems3N2F3d2Y2aWUifQ._j3hKxoBC_Gnh4-qddn8lg',
            'id': 'mapbox.satellite',
          },
        ),
        MarkerLayerOptions(markers: [
          Marker(
              point:
                  userLocation ?? LatLng(18.562323835185673, 73.93812780854178),
              builder: (ctx) =>
                  const FaIcon(FontAwesomeIcons.locationCrosshairs)),
          for (final marker in markersDetails) marker
        ]),
      ],
    );
  }
}
