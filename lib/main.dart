import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dog_help_demo/Screens/Camera.dart';
import 'package:dog_help_demo/Screens/Login.dart';
import 'package:dog_help_demo/Screens/SaveADog.dart';
import 'package:dog_help_demo/Screens/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:dog_help_demo/Screens/Home.dart';
import 'package:dog_help_demo/Screens/DogProfile.dart';
import 'package:camera/camera.dart';
import 'package:dog_help_demo/Screens/lander.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
  runApp(App(camera: firstCamera,));
}

class App extends StatefulWidget {
  final CameraDescription camera;

  App({
    Key key,
    @required this.camera,
  }) : super(key: key);
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  String initialRouteName;
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if(_error) {
      return Text('Something went wrong');
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Center(child: CircularProgressIndicator());
    }

    // initialisation of Firebase Authentication
    FirebaseAuth auth = FirebaseAuth.instance;
    // initialisation of Firebase Storage
    firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
    // Running the main app
    return MaterialApp(
      home: Lander(authInstance: auth,),
      routes: {
        '/Home': (context) => Home(authInstance: auth, storageInstance: storage,),
        '/DogProfile': (context) => DogProfile(),
        '/Camera': (context) => TakePictureScreen(camera: widget.camera),
        '/SaveADog': (context) => SaveADog(),
        '/Login': (context) => Login(authInstance: auth,),
        '/SignUp': (context) => SignUp(authInstance: auth,),
      },
    );
  }
}
