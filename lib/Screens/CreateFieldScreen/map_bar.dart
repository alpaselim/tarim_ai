import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapBar extends StatefulWidget {
  const MapBar({Key? key}) : super(key: key);

  @override
  State<MapBar> createState() => MapBarState();
}

class MapBarState extends State<MapBar> {
  final Completer<GoogleMapController> _controller = Completer();

  // Google API Anahtarınızı buraya girin
  final String _googleApiKey = 'YOUR_GOOGLE_API_KEY';

  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<void> _searchAndNavigate(String address) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=${Uri.encodeComponent(address)}&key=$_googleApiKey'));
    final json = jsonDecode(response.body);

    if (json['results'].isEmpty) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Adres bulunamadı.")));
      return;
    }

    final location = json['results'][0]['geometry']['location'];
    final LatLng position = LatLng(location['lat'], location['lng']);

    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
          infoWindow: InfoWindow(
            title: address,
            snippet: '${position.latitude}, ${position.longitude}',
          ),
        ),
      );
    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 15)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.42796133580664, -122.085749655962),
          zoom: 14.4746,
        ),
        markers: _markers,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Basit bir TextField ile adres sorgulaması yapabilirsiniz
          // Daha karmaşık bir UI için AlertDialog vs. kullanabilirsiniz.
          final TextEditingController controller = TextEditingController();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Adresi Girin'),
                content: TextField(
                  controller: controller,
                  decoration: const InputDecoration(hintText: "Adres"),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Ara'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _searchAndNavigate(controller.text);
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
