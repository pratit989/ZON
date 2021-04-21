import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Lander extends StatefulWidget {
  final FirebaseAuth authInstance;

  Lander({
    Key key,
    @required this.authInstance,
  }) : super(key: key);
  @override
  _LanderState createState() => _LanderState();
}

class _LanderState extends State<Lander> {
  @override
  Widget build(BuildContext context) {
    widget.authInstance
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        Navigator.pushNamed(context, '/Login');
      } else {
        Navigator.pushNamed(context, '/Home');
      }
    });
    return Scaffold(
      body:Center(child: CircularProgressIndicator()),
      backgroundColor: Colors.black,
    );
  }
}
