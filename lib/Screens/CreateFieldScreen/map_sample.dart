import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:tarim_ai/Controllers/location_controller.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Screens/CreateFieldScreen/create_field_screen.dart';

class MapSmple extends StatefulWidget {
  const MapSmple({Key? key}) : super(key: key);

  @override
  State<MapSmple> createState() => MapSmpleState();
}

class MapSmpleState extends State<MapSmple> {
  final LocationController locationController = Get.put(LocationController());

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Map<MarkerId, Marker> markers = {};
  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: const CameraPosition(
              target: LatLng(3.42796133580664, 32.085749655962),
              zoom: 14.4746,
            ),
            onTap: _handleTap,
            markers: Set<Marker>.of(markers.values),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            bottom: 100, // Adjust the position as needed
            left: 0,
            right: 0,
            child: Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.room,
                        size: 35,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Obx(() => Text(
                              locationController.address.value,
                              style: const TextStyle(fontSize: 16),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 45, // Adjust the position as needed
            left: 0,
            right: 0,
            child: Center(
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: kRedColor,
                    borderRadius: BorderRadius.circular(
                        10), // Kenarlara oval şekil vermek için
                  ),
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => const CreateField());
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          kWhiteColor), // Yazı rengi kırmızı
                      backgroundColor: MaterialStateProperty.all<Color>(
                          kRedColor), // Arka plan rengi beyaz
                    ),
                    child: const Text(
                      'Konumu Doğrula',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _handleTap(LatLng tappedPoint) {
    final MarkerId markerId = MarkerId(DateTime.now().toIso8601String());
    final Marker marker = Marker(
      markerId: markerId,
      position: tappedPoint,
      infoWindow: InfoWindow(
        title: 'New Location',
        snippet: '${tappedPoint.latitude}, ${tappedPoint.longitude}',
      ),
    );

    placemarkFromCoordinates(tappedPoint.latitude, tappedPoint.longitude)
        .then((placemarks) {
      var output = 'No results found.';
      if (placemarks.isNotEmpty) {
        output =
            '${placemarks[0].name}, ${placemarks[0].subAdministrativeArea}, ${placemarks[0].administrativeArea}, ${placemarks[0].country}';
      }

      // Controller ile veriyi güncelleyin
      locationController.updateLocation(tappedPoint, output);
    });

    setState(() {
      markers.clear();
      markers[markerId] = marker;
    });
  }
}
