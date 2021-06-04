import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  late LatLng currentPosition;

  late Set<Marker> _markers = {};

  bool _error = false;
  bool _initialized = false;

  void _getUserLocation() async {
    try {
      var position = await GeolocatorPlatform.instance
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
      _initialized = true;
      _error = false;
    });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    _getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return Text('Something went wrong');
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Center(child: CircularProgressIndicator());
    }
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('Map Navigator'),
      ),
      body: GoogleMap(
        markers: _markers,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: currentPosition,
          zoom: 40
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: _handleTap,
      ),
    );
  }

  _handleTap(LatLng point) {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: 'I am a marker',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
    });
  }
}