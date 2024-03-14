import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  static final CameraPosition  cameraPosition = const CameraPosition(
      target: LatLng(37.7749, -122.4194),
    zoom: 13
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Example'),
      ),
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
      ),
    );
  }
}
