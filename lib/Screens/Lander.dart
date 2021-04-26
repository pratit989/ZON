import 'package:dog_help_demo/Screens/Home.dart';
import 'package:dog_help_demo/Screens/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Lander extends StatefulWidget {
  final FirebaseAuth authInstance;
  final firebase_storage.FirebaseStorage storageInstance;

  Lander({
    required this.authInstance,
    required this.storageInstance,
  });

  @override
  _LanderState createState() => _LanderState();
}

class _LanderState extends State<Lander> {
  @override
  Widget build(BuildContext context) {
    if (widget.authInstance.currentUser != null) {
      return Home(
          authInstance: widget.authInstance,
          storageInstance: widget.storageInstance);
    } else {
      return Login(authInstance: widget.authInstance);
    }
  }
}
