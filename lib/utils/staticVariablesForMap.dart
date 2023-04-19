import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:vcharge/view/homeScreen/widgets/bgMap.dart';

import '../models/stationModel.dart';
import '../view/stationsSpecificDetails/stationsSpecificDetails.dart';
import 'availabilityColorFunction.dart';

class StaticVariablesForMap {
  static String userId = "USR20230410144618685";

  // map controller for accessing map properties
  static MapController mapController = MapController();


  static List<RequiredStationDetailsModel> stationsData = [];

   // the user's live location data
  static LatLng? userLocation;

  // this is the list which stores the markers related to the all stations on the map
  static List<Marker> markersDetails = [];

  static Future<void> getMarkersDetails(BuildContext context, List<dynamic> stationsData) async {
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
                          stationId: idx,
                          userId: userId,
                        )));
          },
          child: FaIcon(
            FontAwesomeIcons.locationDot,
            size: 30,
            color: AvaliblityColor.getAvailablityColor(idx.stationStatus!),
          ),
        ),
      );
    }).toList();
  }


}