import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:vcharge/models/stationModel.dart';
import 'package:vcharge/services/GetMethod.dart';
import 'package:vcharge/view/stationsSpecificDetails/stationsSpecificDetails.dart';

class BgMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BgMapState();
}

class BgMapState extends State<BgMap> {
  var stationsData;
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    // getStationData();
  }

  Future<void> getStationData() async {
    print('Getting Station data');
    var data =
        await GetMethod.getRequest('http://192.168.0.113:8081/vst1/stations');
    if (data.isNotEmpty) {
      stationsData = data;
    }
    print('Station data fetched');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlutterMap(
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
              'id': 'mapbox.mapbox-streets-v8',
            },
          ),
          MarkerLayerOptions(markers: [
            Marker(
              // width: 20.0,
              // height: 20.0,
              point: LatLng(18.5434725, 73.9336914),
              builder: (ctx) => Container(
                child: IconButton(
                  icon: Icon(Icons.location_on),
                  color: Colors.red,
                  iconSize: 40.0,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => StationsSpecificDetails(StationModel(
                      stationName: "Charging Station",
                      stationChargerList: [
                        {
                          'chargerName': 'ABC',
                          'chargerType': 'Public',
                          'chargerStatus': 'Available',
                          'chargerConnectorType': 'Type 2'
                        },
                        {
                          'chargerName': 'Xyzabc',
                          'chargerType': 'Privte',
                          'chargerStatus': 'Busy',
                          'chargerConnectorType': 'CSS 2'
                        },
                      ]
                      ))) );
                  },
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

