import 'dart:developer';

import 'package:dog_help_demo/Backend/FirebaseStorageManager.dart';
import 'package:dog_help_demo/Screens/Home.dart';
import 'package:dog_help_demo/Screens/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Lander extends StatefulWidget {

  @override
  _LanderState createState() => _LanderState();
}

class _LanderState extends State<Lander> {

  bool? initialized = false;
  var userCache;

  void initialize() async {
    if (userCache != authInstance.currentUser) {
      User user = authInstance.currentUser!;
      if (!user.emailVerified) {
          Navigator.pushReplacementNamed(context, '/CheckEmail');
      }
      try {
        userCache = authInstance.currentUser ?? null;
        // Get Profile Picture download URL
        profileURL =
        await storageManager.getDownloadURL(profilePictureReferenceURL);
        // Get User Data
        firestoreUserData = await firestoreManager.getUserData();
        setState(() {
          initialized = true;
        });
      } catch (e) {
        log('Lander Screen Error: $e');
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (authInstance.currentUser != null) {
      initialize();
    } else {initialized = null;}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized == true) {
      return Home();
    } else if (initialized == null) {
      return Login();
    } else if (initialized == false) {
      return Center(child: CircularProgressIndicator(color: Colors.amber));
    }
    return Text('Something went wrong in Lander Screen');
  }
}
