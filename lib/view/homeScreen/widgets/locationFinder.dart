import 'package:flutter/material.dart';


class LocationFinder extends StatefulWidget {
  const LocationFinder({super.key});

  @override
  State<LocationFinder> createState() => LocationFinderState();
}

class LocationFinderState extends State<LocationFinder> {
bool _locationFinder = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
  }
}