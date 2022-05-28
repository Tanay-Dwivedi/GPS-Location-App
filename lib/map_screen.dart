import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import "package:flutter_map/flutter_map.dart";
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class MapScreen extends StatelessWidget {
  MapScreen({Key? key, required this.lati, required this.longi})
      : super(key: key);

  final _screenshotController = ScreenshotController();

  final String lati;
  final String longi;
  final String apiKey = "06zU1pnrAR1lZwcZguKDycIgIE8zoxWq";

  @override
  Widget build(BuildContext context) {
    late double latVal = double.parse(lati);
    late double lngVal = double.parse(longi);
    final LatLng place = LatLng(latVal, lngVal);
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Screenshot(
              controller: _screenshotController,
              child: FlutterMap(
                options: MapOptions(center: place, zoom: 13.0),
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
                        point: place,
                        builder: (BuildContext context) => const Icon(
                            Icons.location_on,
                            size: 60.0,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 500, 0, 0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final snapImage = await _screenshotController.capture();
                    if (snapImage == null) {
                      return;
                    } else {
                      await saveImage(snapImage);
                      saveAndShare(snapImage);
                    }
                  },
                  child: const Text('Take SnapShot'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);
    await Share.shareFiles([image.path]);
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();

    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');

    final name = 'ScreenShot_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result['filePath'];
  }
}
