import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vcharge/view/homeScreen/widgets/bgMap.dart';

import '../../../services/getLiveLocation.dart';
import '../../../services/redisConnection.dart';

class LocationFinder extends StatefulWidget {
  //getting mapController as parameter
  final VoidCallback updateState;
  LocationFinder({required this.updateState, super.key});

  @override
  State<LocationFinder> createState() => LocationFinderState();
}

class LocationFinderState extends State<LocationFinder>
    with TickerProviderStateMixin {
  //variable for location finder
  bool locationFinder = false;

  Future<void> getToUserLocation() async {
    var userLat = await RedisConnection.get('userLatitude');
    var userLong = await RedisConnection.get('userLongitude');
    BgMapState.userLocation = LatLng(double.parse(userLat), double.parse(userLong));

    if (mounted) {
      // Call the animatedMapMove method only if the widget is still mounted
      animatedMapMove(BgMapState.userLocation!, 15.0);
    }
  }

  @override
  void initState() {
    super.initState();
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
    final controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      setState(() {
        BgMapState.mapController.move(
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          getToUserLocation();
        },
        child: Container(
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(blurRadius: 5, color: Colors.grey, spreadRadius: 1)
          ], borderRadius: BorderRadius.circular(30)),
          margin: const EdgeInsets.only(right: 13, bottom: 10),
          child: CircleAvatar(
            backgroundColor: locationFinder ? Colors.blue : Colors.white,
            child: const FaIcon(
              FontAwesomeIcons.locationCrosshairs,
              color: Colors.black,
            ),
          ),
        ));
  }
}
