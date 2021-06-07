import 'package:dog_help_demo/Screens/Home.dart';
import 'package:dog_help_demo/Screens/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Lander extends StatefulWidget {

  @override
  _LanderState createState() => _LanderState();
}

class _LanderState extends State<Lander> {
  @override
  Widget build(BuildContext context) {
    if (authInstance.currentUser != null) {
      return Home();
    } else {
      return Login();
    }
  }
}
