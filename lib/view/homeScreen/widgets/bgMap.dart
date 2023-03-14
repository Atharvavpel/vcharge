import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class BgMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BgMapState();
}

class BgMapState extends State<BgMap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(18.5434725,73.9336914), // San Francisco, CA
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 40.0,
                height: 40.0,
                point: LatLng(18.5434725,73.9336914),
                builder: (ctx) => Container(
                  child: IconButton(
                    icon: Icon(Icons.location_on),
                    color: Colors.red,
                    iconSize: 40.0,
                    onPressed: () {
                      // Perform action on tap
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
