import 'package:flutter/material.dart';
import "package:flutter_map/flutter_map.dart";
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  MapScreen({Key? key}) : super(key: key);
    final LatLng tomtomHQ = LatLng(52.376372, 4.908066);
  final String apiKey = "06zU1pnrAR1lZwcZguKDycIgIE8zoxWq";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            FlutterMap(
              options: MapOptions(center: tomtomHQ, zoom: 13.0),
              layers: [
                TileLayerOptions(
                  urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
                      "{z}/{x}/{y}.png?key={apiKey}",
                  additionalOptions: {"apiKey": apiKey},
                ),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 75.0,
                      height: 75.0,
                      point: tomtomHQ,
                      builder: (BuildContext context) => const Icon(
                          Icons.location_on,
                          size: 60.0,
                          color: Colors.blue),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
