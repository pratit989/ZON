import 'package:dog_help_demo/Backend/FirebaseStorageManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'ProfilePicture.dart';

class ProfilePage extends StatefulWidget {
  final FirebaseStorage storageInstance;
  final FirebaseAuth authInstance;

  ProfilePage({required this.storageInstance, required this.authInstance});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final FirebaseStorageManager storageManager = FirebaseStorageManager(
      storageInstance: widget.storageInstance,
      authInstance: widget.authInstance);

  // Download URL for profile picture
  late String profileURL;

  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to get Download URL for Profile Picture
  void initializeProfile() async {
    try {
      // Wait to get Download URl for Profile Picture
      profileURL = await storageManager
          .getDownloadURL(storageManager.profilePictureReferenceURL);
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeProfile();
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.red,
      ),
      body: Container(
          color: Colors.white,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              GestureDetector(
                onTap: () async {
                  print('tapped');
                  await Navigator.pushNamed(context, ExtractArguments.routeName,
                      arguments: PictureDisplay(
                        url: profileURL,
                        auth: widget.authInstance,
                        storage: widget.storageInstance,
                      ));
                  initializeProfile();
                  setState(() {});
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.05),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    backgroundImage: NetworkImage(profileURL),
                    minRadius: 50,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(50)),
                    color: Colors.grey),
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppBar(
                      title: Text('Personal Details'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ' +
                            widget.authInstance.currentUser!.displayName!),
                        Text('Email: ' +
                            widget.authInstance.currentUser!.displayName!),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
