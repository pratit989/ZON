import 'package:dog_help_demo/Screens/Camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geocoder/geocoder.dart';

import '../main.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController _controller;
  late TextEditingController _controllerField = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
      _handleTap(currentPosition);
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
      return Center(child: CircularProgressIndicator(color: Colors.amber));
    }
    return new Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            markers: _markers,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: currentPosition,
              zoom: 15.0
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
            onTap: _handleTap,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Transform.translate(
              offset: Offset(0.0, -160),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  heroTag: 'locate',
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () async {
                    Position position = await GeolocatorPlatform.instance.getCurrentPosition();
                    _handleTap(LatLng(position.latitude, position.longitude));
                    setState(() {
                      _controller.moveCamera(CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));
                    });
                  },
                  backgroundColor: Colors.amber,
                  child: Icon(Icons.location_on, color: Colors.black87,),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Transform.translate(
                offset: Offset(0, -90),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        heroTag: 'tick',
                        onPressed: () {
                          location = _controllerField.value.text;
                          if (imagePath == null) {
                            Navigator.pushReplacementNamed(context, '/Camera');
                          } else {
                            Navigator.pushReplacementNamed(context, '/SubmitAnimalProfile');
                          }
                        },
                        backgroundColor: Colors.amber,
                        child: Icon(Icons.check, color: Colors.black87,),
                      ),
                    ),
                  ],
                )
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  color: Colors.amber
                ),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: RawMaterialButton(
                            fillColor: Colors.transparent,
                            elevation: 0,
                            child: Icon(
                              Icons.search,
                              size: MediaQuery.of(context).size.width * 0.1,
                              color: Colors.black,
                            ),
                            // Provide an onPressed callback.
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a Snackbar.
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Processing Data')));
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: TextFormField(
                              controller: _controllerField,
                              cursorColor: Colors.black,
                              textCapitalization: TextCapitalization.words,
                              style: TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter some text';
                                } else {
                                  _initialized = false;
                                  _getCoordinates(value);
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ]
      ),
    );
  }

  _handleTap(LatLng point) async {
    var coordinates = new Coordinates(point.latitude, point.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(point.toString()),
        draggable: true,
        position: point,
        infoWindow: InfoWindow(
          title: first.addressLine,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        onDragEnd: ((newPosition) {
          print(newPosition.latitude);
          print(newPosition.longitude);
        })
      ));
      _controllerField.value = TextEditingValue(text: first.addressLine);
    });
  }

  _getCoordinates(String query) async {
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    Coordinates coordinates =  first.coordinates;
    currentPosition = LatLng(coordinates.latitude, coordinates.longitude);
    _handleTap(currentPosition);
    LatLng position = LatLng(coordinates.latitude, coordinates.longitude);
    await _handleTap(position);
    setState(() {
      _controller.moveCamera(CameraUpdate.newLatLng(position));
      _initialized = true;
    });
  }
}