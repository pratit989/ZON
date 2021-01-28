import 'dart:async';

import 'package:dog_help_demo/Screens/Camera.dart';
import 'package:dog_help_demo/Screens/Login.dart';
import 'package:dog_help_demo/Screens/SaveADog.dart';
import 'package:dog_help_demo/Screens/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:dog_help_demo/Screens/Home.dart';
import 'package:dog_help_demo/Screens/DogProfile.dart';
import 'package:camera/camera.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
  runApp(MaterialApp(
    initialRoute: '/Home',
    routes: {
      '/Home': (context) => Home(),
      '/DogProfile': (context) => DogProfile(),
      '/Camera': (context) => TakePictureScreen(camera: firstCamera),
      '/SaveADog': (context) => SaveADog(),
      '/Login': (context) => Login(),
      '/SignUp': (context) => SignUp(),
    },
  ));
}
