import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LocationFinder extends StatefulWidget {
  const LocationFinder({super.key});

  @override
  State<LocationFinder> createState() => LocationFinderState();
}

class LocationFinderState extends State<LocationFinder> {

  //variable for location finder
  bool locationFinder = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(blurRadius: 5, color: Colors.grey, spreadRadius: 1)
      ],
      borderRadius: BorderRadius.circular(30)),
      margin: const EdgeInsets.only(right: 13, bottom: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            locationFinder = true;
          });
          Future.delayed(const Duration(seconds: 2)).then((_) {
            setState(() {
              locationFinder = false;
            });
          });
        },
        child: CircleAvatar(
          backgroundColor: locationFinder ? Colors.blue : Colors.white,
          child: const FaIcon(
            FontAwesomeIcons.locationCrosshairs,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
