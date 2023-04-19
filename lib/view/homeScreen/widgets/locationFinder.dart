import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:vcharge/services/getLiveLocation.dart';

import '../../../utils/staticVariablesForMap.dart';

class LocationFinder extends StatefulWidget {
  //getting mapController as parameter
  MapController mapController;
  LocationFinder({required this.mapController, super.key});

  @override
  State<LocationFinder> createState() => LocationFinderState();
}

class LocationFinderState extends State<LocationFinder>
    with TickerProviderStateMixin {
  //initializing mapController in this state
  // MapController? mapController;

  //variable for location finder
  bool locationFinder = false;

  @override
  void initState() {
    super.initState();
  }

  //This function is use to animate the map when the mapController.move() is called
  void animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: StaticVariablesForMap.mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: StaticVariablesForMap.mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: StaticVariablesForMap.mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    final controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      setState(() {
        StaticVariablesForMap.mapController.move(
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
        splashColor: Colors.blue,
        onTap: () async {
          //first getting the location of the user
          var position = await GetLiveLocation.getUserLiveLocation();
          //then animating him to his location
          animatedMapMove(position, 15);
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

/*
Container(
              margin: const EdgeInsets.only(right: 13, bottom: 10),
              decoration: BoxDecoration(
                  color: _locationFinder ? Colors.blue : Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 10, color: Colors.grey, spreadRadius: 2)
                  ],
                  borderRadius: BorderRadius.circular(100)),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      _locationFinder = true;
                    });
                    Future.delayed(const Duration(seconds: 2)).then((_) {
                      setState(() {
                        _locationFinder = false;
                      });
                    });
                  },
                  icon: const Icon(
                    Icons.my_location,
                    size: 20,
                  )),
            );
*/
