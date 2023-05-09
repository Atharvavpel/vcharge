import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'dart:math' as Math;
import 'package:latlong2/latlong.dart';
import 'package:vcharge/models/stationModel.dart';
import 'package:vcharge/services/getLiveLocation.dart';
import 'package:vcharge/services/getMethod.dart';
import 'package:vcharge/services/redisConnection.dart';
import 'package:vcharge/view/stationsSpecificDetails/stationsSpecificDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/availabilityColorFunction.dart';
import '../homeScreen.dart';

class BgMap extends StatefulWidget {
  String userId;

  BgMap({required this.userId, super.key});

  @override
  State<StatefulWidget> createState() => BgMapState();

  //this is setter function for mapController, so that we can set mapvalue outside this dart file
  // static void setMapController(LatLng position) {
  //   BgMapState.mapController.move(position, 13);
  // }
}

class BgMapState extends State<BgMap> with TickerProviderStateMixin {
  String url_temp = 'http://192.168.0.243:8096/manageStation/stations';

  // the user's live location data
  static LatLng? userLocation;

  AnimationController? animationController;

  // map controller for accessing map properties
  static MapController mapController = MapController();

  static StreamSubscription? subscription;

  // list which loads the station data
  static List<RequiredStationDetailsModel> stationsData = [];

  // this is the list which stores the markers related to the all stations on the map
  static List<Marker> markersDetails = [];

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    // redisTest();
  }

  // void redisTest() async{
  //   await RedisConnection.set('any', 'thing');
  //   print(await RedisConnection.get('any'));
  // }
  
  @override
  void dispose() {
    animationController?.dispose();
    // Cancel any ongoing asynchronous operation when the widget is disposed
    super.dispose();
  }

// this function is used to fetch the station data and embed it into the stationsData variable
  Future<void> getStationData(String url) async {
    try {
      var data = await GetMethod.getRequest(url);
      if (data.isNotEmpty) {
        print('Data Not Empty');
        stationsData.clear();
        for (int i = 0; i < data.length; i++) {
          stationsData.add(RequiredStationDetailsModel.fromJson(data[i]));
        }
        print(stationsData);
        setState(() {
          BgMapState.getMarkersDetails(context, stationsData);
        });
      }
      else{
        print("Empty Data");
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> getMarkersDetails(BuildContext context,
      List<RequiredStationDetailsModel> stationsData) async {
    try {
        markersDetails = stationsData.map((idx) {
          return Marker(
            // width: 20.0,
            // height: 20.0,
            anchorPos:
                AnchorPos.align(AnchorAlign.center), //change center to bottom
            point: LatLng(idx.stationLatitude!,
                idx.stationLongitude!),
            builder: (ctx) => Semantics(
              label: "StationMarker",
              hint: "Redirect you to sspecific details of that station",
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StationsSpecificDetails(
                                stationId: idx.stationId!,
                                userId: HomeScreenState.userId,
                              )));
                },
                child: FaIcon(
                  FontAwesomeIcons.locationDot,
                  size: 30,
                  color: AvaliblityColor.getAvailablityColor(idx.stationStatus!),
                ),
              ),
            ),
          );
        }).toList();
    } catch (e) {
      // TODO
      print(e);
    }
  }

  //This function get the live location of the user using GetLiveLocation class
  Future<void> getLocation() async {
    var userLat = await RedisConnection.get('userLatitude');
    var userLong = await RedisConnection.get('userLongitude');

    if (userLat != null && userLong != null) {
      BgMapState.userLocation = LatLng(double.parse(userLat),double.parse(userLong));
      var currentLocation = await GetLiveLocation.getUserLiveLocation();
      if(currentLocation.latitude!=userLat && currentLocation.longitude!=userLong){
        setState(() {
          BgMapState.userLocation = currentLocation;
        });
      }
    } 
    
    else {
      BgMapState.userLocation = await GetLiveLocation.getUserLiveLocation();
      
      //store current location of user in local Storage such that we can fetch it
      await RedisConnection.set('userLatitude', BgMapState.userLocation!.latitude.toString());
      await RedisConnection.set('userLongitude', BgMapState.userLocation!.longitude.toString());
    }

    if (mounted) {
      // Call the animatedMapMove method only if the widget is still mounted
      animatedMapMove(BgMapState.userLocation!, 15.0);
    }
  }

  //This function is use to animate the map when the mapController.move() is called
  void animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: BgMapState.mapController.center.latitude,
        end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: BgMapState.mapController.center.longitude,
        end: destLocation.longitude);
    final zoomTween =
        Tween<double>(begin: BgMapState.mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    // animationController = AnimationController(
    //     duration: const Duration(milliseconds: 1000), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    final Animation<double> animation =
        CurvedAnimation(parent: animationController!, curve: Curves.easeInOut);
    // Create a TickerFuture that completes when the animation has finished.
    final animationFuture = animationController!.animateTo(1.0);

    animationController!.addListener(() {
      if (mounted) {
        setState(() {
          BgMapState.mapController.move(
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

  //To calculate the distance between two points on the Earth's surface given their latitude and longitude coordinates, you can use the Haversine formula.
  double getDistance(LatLng latLng1, LatLng latLng2) {
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

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: BgMapState.mapController,
      options: MapOptions(
          minZoom: 3,
          maxZoom: 17.0,
          center: BgMapState.userLocation,
          zoom: 15.0,
          //by this command, the map will not be able to rotate
          interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
          onMapReady: () async {
            await getLocation();
            subscription =
                mapController.mapEventStream.listen((MapEvent mapEvent) {
              if (mapEvent is MapEventMoveEnd) {
                // print('Hit');
                // print(BgMapState.mapController.center.longitude.toDouble());
                double long = BgMapState.mapController.center.longitude;
                double lat = BgMapState.mapController.center.latitude;
                double dist = getDistance(
                        BgMapState.mapController.bounds!.northEast!,
                        BgMapState.mapController.bounds!.southWest!) *1000;
                getStationData(
                    'http://192.168.0.243:8096/manageStation/getStationsLocation?longitude=$long&latitude=$lat&maxDistance=$dist');
              }
            });
            // BgMapState.userLocation = mapController.center;
          },
        ),
      children: [
        //tile layer
        TileLayer(
          urlTemplate:
              'https://api.mapbox.com/styles/v1/atharva70/clf990hij00ck01pg9fcgv02h/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYXRoYXJ2YTcwIiwiYSI6ImNsZjk3cTUxZDJjc2czems3N2F3d2Y2aWUifQ._j3hKxoBC_Gnh4-qddn8lg',
          additionalOptions: const {
            'accessToken':
                'pk.eyJ1IjoiYXRoYXJ2YTcwIiwiYSI6ImNsZjk3cTUxZDJjc2czems3N2F3d2Y2aWUifQ._j3hKxoBC_Gnh4-qddn8lg',
            'id': 'mapbox.satellite',
          },
        ),

        //location marker
        MarkerLayer(
          markers: [
            //user location marker
            Marker(
              anchorPos: AnchorPos.align(AnchorAlign.center),
              point: BgMapState.userLocation ??
                  LatLng(18.562323835185673, 73.93812780854178),
              builder: (ctx) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  // boxShadow: const [
                  //   offset: Offset(1, 1)
                  //   BoxShadow(color: Color.fromARGB(255, 255, 255, 255),spreadRadius: 3)
                  // ]
                ),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.locationCrosshairs,
                    color: Colors.green,
                    size: Get.width * 0.05,
                  ),
                ),
              ),
            ),
          ],
        ),

        //cluster layer
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
              for (final marker in BgMapState.markersDetails) marker
            ],
            builder: (context, markers) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 5,
                color: Colors.green,
                child: Center(
                  child: Text(
                    markers.length.toString(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
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
