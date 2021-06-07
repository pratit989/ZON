import 'package:dog_help_demo/Backend/FirebaseStorageManager.dart';
import 'package:dog_help_demo/Backend/FirestoreManager.dart';
import 'package:dog_help_demo/Widgets/Drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  late final FirestoreManager firestoreManager =
  FirestoreManager(authInstance: widget.authInstance);

  Map<String, dynamic>? data;

  TextStyle dataName = TextStyle(
    color: Colors.black26,
    fontWeight: FontWeight.w800,
    fontSize: 15
  );
  TextStyle userData = TextStyle();

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
      data = await firestoreManager.getUserData();
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
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.amber,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height/4,
              left: 20,
              right: 20,
              bottom: 5
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 10,
                      top: 8,
                      left: 40,
                      right: 40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.1,
                              ),
                              child: Text(
                                  widget.authInstance.currentUser!.displayName!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 5,
                            left: (MediaQuery.of(context).size.width-220)/2
                          ),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Colors.black54,
                              ),
                              width: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                      Icons.edit,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Edit Profile',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Data
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                            bottom: 15
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 8
                                ),
                                child: Text(
                                    'Email Address',
                                  style: dataName,
                                ),
                              ),
                              Text(
                                  widget.authInstance.currentUser!.email!,
                                style: userData,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30,
                                    bottom: 8
                                ),
                                child: Text(
                                  'Phone',
                                  style: dataName,
                                ),
                              ),
                              Text(
                                data!['phone_no'].toString(),
                                style: userData,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30,
                                    bottom: 8
                                ),
                                child: Text(
                                  'User Type',
                                  style: dataName,
                                ),
                              ),
                              Text(
                                data!['user_type'],
                                style: userData,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0,
                          bottom: 8,
                          right: 8,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          height: MediaQuery.of(context).size.height/5,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30
                                ),
                                child: Text(
                                  '50₹',
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                              Text(
                                'Donations',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          height: MediaQuery.of(context).size.height/5,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30
                                ),
                                child: Text(
                                  '10',
                                  style: TextStyle(
                                      fontSize: 50,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                              Text(
                                'Dogs Saved',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(
                (MediaQuery.of(context).size.width - (MediaQuery.of(context).size.height * 0.1)*2)/2,
                (MediaQuery.of(context).size.width - (MediaQuery.of(context).size.height * 0.1)*2)/2
            ),
            child: GestureDetector(
              onTap: () async {
                print('tapped');
                await Navigator.pushNamed(context, ExtractArguments.routeName,
                    arguments: PictureDisplay(
                      auth: widget.authInstance,
                      storage: widget.storageInstance,
                ));
                initializeProfile();
                setState(() {});},
              child : CircleAvatar(
                radius: MediaQuery.of(context).size.height * 0.1,
                backgroundColor: Colors.black,
                child: ClipOval(child: Image.network(profileURL)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
