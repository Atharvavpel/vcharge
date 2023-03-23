import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:vcharge/models/markerDetails.dart';
import 'package:vcharge/models/stationModel.dart';
import 'package:vcharge/services/getMethod.dart';
import 'package:vcharge/view/stationsSpecificDetails/stationsSpecificDetails.dart';

class BgMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BgMapState();
}

class BgMapState extends State<BgMap> {
  //
  MapController mapController = MapController();

  // list which loads the station data
  List<StationModel> stationsData = [];

  // this is the list which stores the markers related to the all stations on the map
  List<Marker> markersDetails = [];

  @override
  void initState() {
    super.initState();
    getStationData();
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
    print('Getting Station data');
    var data =
        await GetMethod.getRequest('http://192.168.0.113:8081/vst1/stations');
    if (data.isNotEmpty) {
      stationsData = data.map((e) {
        return StationModel(
          stationName: e['stationName'],
          stationHostId: e['stationHostId'],
          stationVendorId: e['stationVendorId'],
          stationLocation: e['stationLocation'],
          stationLatitude: e['stationLatitude'],
          stationLongitude: e['stationLongitude'],
          stationLocationURL: e['stationLocationURL'],
          stationParkingArea: e['stationParkingArea'],
          stationContactNumber: e['stationContactNumber'],
          stationWorkingTime: e['stationWorkingTime'],
          stationParkingType: e['stationParkingType'],
          stationAmenity: e['stationAmenity'],
          stationChargerList: e['stationChargerList'],
          stationStatus: e['stationStatus'],
          stationBooking: e['stationBooking'],
          stationPowerStandard: e['stationPowerStandard'],
        );
      }).toList();
      print(stationsData);
      setState(() {
        getMarkersDetails();
      });
    }
    print('Station data fetched');
  }

  Future<void> getMarkersDetails() async {
    print('Getting makers details');
    markersDetails = stationsData.map((idx) {
      print('${idx.stationLatitude} ${idx.stationLongitude} \n');
      return Marker(
        // width: 20.0,
        // height: 20.0,
        anchorPos:
            AnchorPos.align(AnchorAlign.center), //change center to bottom
        point: LatLng(double.parse(idx.stationLatitude!),
            double.parse(idx.stationLongitude!)),
        builder: (ctx) => Container(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StationsSpecificDetails(idx)
                    )
                  );
            },
            child: FaIcon(
              FontAwesomeIcons.locationDot,
              size: 30,
              color: getAvailablityColor(idx.stationStatus!),
            ),
          ),
        ),
      );
    }).toList();
    print('makers details fetched');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          minZoom: 3.8,
          maxZoom: 17.0,
          center: LatLng(18.5434725, 73.9336914), // San Francisco, CA
          zoom: 14.0,
          interactiveFlags: InteractiveFlag.pinchZoom |
              InteractiveFlag
                  .drag, //by this command, the map will not be able to rotate
        ),
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
          MarkerLayerOptions(markers: markersDetails),
        ],
      ),
    );
  }
}




// Marker(
//               // width: 20.0,
//               // height: 20.0,
//               anchorPos:
//                   AnchorPos.align(AnchorAlign.center), //change center to bottom
//               point: LatLng(stationsData[e]['stationLatitude'], stationsData[e][]),
//               builder: (ctx) => Container(
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                                 StationsSpecificDetails(StationModel(
//                                     stationName: "Pride Icon Charging Station",
//                                     stationChargerList: [
//                                       {
//                                         'chargerName': 'ABC',
//                                         'chargerId': '000234567',
//                                         'chargerType': 'Public',
//                                         'chargerStatus': 'Available',
//                                         'chargerConnectorType': 'Type 2',
//                                         'chargerCostPerKWH': '30.00'
//                                       },
//                                       {
//                                         'chargerName': 'Xyzabc',
//                                         'chargerId': '000876543',
//                                         'chargerType': 'Private',
//                                         'chargerStatus': 'Busy',
//                                         'chargerConnectorType': 'CSS 2',
//                                         'chargerCostPerKWH': '25.00'
//                                       },
//                                       {
//                                         'chargerName': 'Mnopqr',
//                                         'chargerId': '000567488',
//                                         'chargerType': 'Public',
//                                         'chargerStatus': 'NotAvailable',
//                                         'chargerConnectorType': 'CSS 2',
//                                         'chargerCostPerKWH': '28.00'
//                                       },
//                                     ]))));
//                   },
//                   child: FaIcon(
//                     FontAwesomeIcons.locationDot,
//                     size: 30,
//                     color: getAvailablityColor('Available'),
//                   ),
//                 ),
//               ),
//             );