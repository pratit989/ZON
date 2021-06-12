import 'dart:async';
import 'dart:core';
import 'dart:developer';
import 'package:dog_help_demo/Screens/AnimalAdoptionAdvertise.dart';
import 'package:dog_help_demo/Screens/CheckEmail.dart';
import 'package:dog_help_demo/Screens/EditProfile.dart';
import 'package:dog_help_demo/Screens/Maps.dart';
import 'package:dog_help_demo/Screens/MessagingInterface.dart';
import 'package:dog_help_demo/Screens/NGOHome.dart';
import 'package:dog_help_demo/Screens/NGOProfileEditPage.dart';
import 'package:dog_help_demo/Screens/ProfilePage.dart';
import 'package:dog_help_demo/Screens/ProfilePicture.dart';
import 'package:dog_help_demo/Screens/SubmitAnimalProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dog_help_demo/Screens/Camera.dart';
import 'package:dog_help_demo/Screens/Login.dart';
import 'package:dog_help_demo/Screens/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:dog_help_demo/Screens/Home.dart';
import 'package:dog_help_demo/Screens/ViewAnimalProfile.dart';
import 'package:camera/camera.dart';
import 'package:dog_help_demo/Screens/Lander.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:dog_help_demo/Screens/Notifications.dart';


import 'Backend/FirebaseStorageManager.dart';
import 'Backend/FirestoreManager.dart';
import 'Screens/NGOProfilePage.dart';
import 'Widgets/UserHomeCarousel.dart';

// initialisation of Firebase Authentication
FirebaseAuth authInstance = FirebaseAuth.instance;
// initialisation of Firebase Storage
FirebaseStorage storageInstance = FirebaseStorage.instance;
// Global Variables
late String? location;
late String profileURL;
Map<String, dynamic>? firestoreUserData;
List<String> ngoNamesList = [];
late final FirebaseStorageManager storageManager = FirebaseStorageManager();
late final FirestoreManager firestoreManager = FirestoreManager();
Map<String, dynamic>? rescueRequests;
List<String> downloadURLs = [];
List<String> carousalReferenceUrlList = [];
Widget uerCarousal = UserHomeCarousel();
Map<String, dynamic>? caseNotificationsData;

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
    required this.camera,
  });
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late String initialRouteName;
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      await FirebaseAppCheck.instance.activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      log('Main Error: $e');
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
      return Center(child: CircularProgressIndicator(color: Colors.amber));
    }

    // Running the main app
    return MaterialApp(
      home: Lander(),
      routes: {
        '/Main': (context) => App(camera: widget.camera),
        '/Lander': (context) => Lander(),
        '/Home': (context) => Home(),
        '/ViewAnimalProfile': (context) => ViewAnimalProfile(),
        '/Camera': (context) => TakePictureScreen(camera: widget.camera),
        '/Login': (context) => Login(),
        '/SignUp': (context) => SignUp(),
        ExtractArguments.routeName: (context) => ExtractArguments(),
        '/ProfilePage': (context) => ProfilePage(),
        '/Map': (context) => MapSample(),
        '/Notifications': (context) => Notifications(),
        '/NGOHome': (context) => NGOHome(),
        '/EditProfile': (context) => EditProfileData(),
        '/NGOEditProfile': (context) => NGOProfileEditPage(),
        '/NGOProfilePage': (context) => NGOProfilePage(),
        '/Messages': (context) => MessagingInterface(),
        '/SubmitAnimalProfile': (context) => SubmitAnimalProfile(),
        '/CheckEmail': (context) => VerifyScreen(),
        '/AnimalAdoptionAdvertise': (context) => AnimalAdoptionAdvertise()
      },
    );
  }
}
