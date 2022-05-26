import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'home_controller.dart';
import 'map_screen.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
//import 'dart:js';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  var txt = TextEditingController();
  var clat = '';
  var clot = '';
  var addressOfTheUser = '';
  //final LatLng place = LatLng(52.376372, 4.908066);

  // getAddress(Value, lat, lng) async {
  //   final Map<String, String> queryParams = {
  //     'key': '06zU1pnrAR1lZwcZguKDycIgIE8zoxWq'
  //   };
  //   queryParams['lat'] = '$lat';
  //   queryParams['lng'] = '$lng';
  //   var response = await http.get(
  //     Uri.https('api.tomtom.com', '/search/2/search/$Value.json', queryParams),
  //   );
  //   var jsonData = jsonDecode(response.body);
  //   print('$jsonData');
  //   var results = jsonData('results');
  //   for (var element in results) {
  //     var position = element['position'];
  //     // var marker = Marker(
  //     //   point: LatLng(position['lat'], position['lng']),
  //     //   width: 50.0,
  //     //   height: 50.0,
  //     // );
  //   }
  //   ;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.green,
                    size: 40,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'User Location',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 30,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => Text(
                      controller.latitude.value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => Text(
                      controller.longitude.value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => Text(
                      controller.address.value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: ElevatedButton(
                      onPressed: () {
                        txt.text = controller.address.value;
                        clat = controller.latitude.value;
                        clot = controller.longitude.value;
                      },
                      child: const Text(
                        'Confirm Address',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      textAlign: TextAlign.left,
                      maxLines: 3,
                      controller: txt,
                      onSubmitted: (value) {
                        //getAddress(addressOfTheUser, clat, clot);
                        addressOfTheUser = value;
                      },
                      style: const TextStyle(
                        color: Colors.black45,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MapScreen(lati: clat, longi: clot)),
                        );
                      },
                      child: const Text(
                        'Find on Map',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
