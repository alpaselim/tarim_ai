import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var address = ''.obs;
  Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);

  void updateLocation(LatLng newLocation, String newAddress) {
    latitude.value = newLocation.latitude;
    longitude.value = newLocation.longitude;
    address.value = newAddress;
    selectedLocation.value = newLocation;
  }
}
