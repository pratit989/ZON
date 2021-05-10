import 'package:dog_help_demo/Backend/FirebaseStorageManager.dart';
import 'package:dog_help_demo/Backend/FirestoreManager.dart';
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

  late final FirestoreManager firestoreManager =
      FirestoreManager(authInstance: widget.authInstance);

  Map<String, dynamic>? data;

  static const TextStyle style1 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle style2 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

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
      drawer: Drawer(
        child: Container(
          color: Colors.black87,
          child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.04,
                vertical: MediaQuery.of(context).size.height * 0.1),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          print('tapped');
                          await Navigator.pushReplacementNamed(
                              context, ExtractArguments.routeName,
                              arguments: PictureDisplay(
                                url: profileURL,
                                auth: widget.authInstance,
                                storage: widget.storageInstance,
                              ));
                          initializeProfile();
                          setState(() {});
                        },
                        child: CircleAvatar(
                          maxRadius: 30,
                          backgroundImage: NetworkImage(profileURL),
                          key: UniqueKey(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.authInstance.currentUser!.displayName!,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize:
                                MediaQuery.of(context).size.width * 0.08,
                              ),
                            ),
                            Text(
                              data!['user_type'],
                              style: TextStyle(
                                  color: Colors.red[300],
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FloatingActionButton.extended(
                          heroTag: 'home',
                          onPressed: () {
                            Navigator.popUntil(context, (route) => route.isFirst);
                          },
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          icon: Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Home',
                            style: TextStyle(color: Colors.white),
                          )),
                      FloatingActionButton.extended(
                          heroTag: 'save a dog',
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/Camera');
                          },
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Save a Dog',
                            style: TextStyle(color: Colors.white),
                          )),
                      FloatingActionButton.extended(
                          heroTag: 'Messages',
                          onPressed: () {},
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          icon: Icon(
                            Icons.message,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Messages',
                            style: TextStyle(color: Colors.white),
                          )),
                      FloatingActionButton.extended(
                          heroTag: 'profile',
                          onPressed: () async {
                            await Navigator.pushReplacementNamed(context, '/ProfilePage');
                          },
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Profile',
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.26,
                  ),
                  Row(
                    children: [
                      FloatingActionButton.extended(
                          heroTag: 'settings',
                          onPressed: () {},
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          icon: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Settings',
                            style: TextStyle(color: Colors.white),
                          )),
                      Text(
                        '|',
                        style: TextStyle(color: Colors.white),
                      ),
                      FloatingActionButton.extended(
                          onPressed: () async {
                            await widget.authInstance.signOut();
                            Navigator.pushReplacementNamed(context, '/Login');
                          },
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          icon: null,
                          label: Text(
                            'Log Out',
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.black,
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0, -0.5),
                  radius: 0.4,
                  colors: [Colors.yellow, Colors.orange])
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              GestureDetector(
                onTap: () async {
                  print('tapped');
                  await Navigator.pushReplacementNamed(context, ExtractArguments.routeName,
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
                    radius: MediaQuery.of(context).size.height * 0.1,
                    backgroundColor: Colors.black,
                    child: ClipOval(child: Image.network(profileURL)),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(50)),
                    color: Colors.white),
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.65,
                ),
                child: Column(
                  children: [
                    AppBar(
                      title: Text('Account Details'),
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.black87,
                    ), // Account Details
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20.0,
                          left: MediaQuery.of(context).size.width * 0.15,
                          bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.person,
                                    size: 40,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Name',
                                      style: style1,
                                    ),
                                    Text(
                                      data!['name'],
                                      style: style2,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ), // Name
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.email,
                                    size: 40,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Email',
                                      style: style1,
                                    ),
                                    Text(
                                      widget.authInstance.currentUser!.email!,
                                      style: style2,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ), // Email
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.phone,
                                    size: 40,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Phone Number',
                                      style: style1,
                                    ),
                                    Text(
                                      data!['phone_no'].toString(),
                                      style: style2,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ), // Phone Number
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.verified_user,
                                    size: 40,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'User Type',
                                      style: style1,
                                    ),
                                    Text(
                                      data!['user_type'],
                                      style: style2,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ), // User Type
                        ],
                      ),
                    ), // Details
                    AppBar(
                      title: Text('User Statistics'),
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.black87,
                    ), // User Statistics
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20.0,
                          bottom: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Dogs Saved',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: style2.fontWeight,
                                      ),
                                    ),
                                    Text(
                                      '10',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: style1.fontWeight,
                                      ),
                                    )
                                  ],
                                )
                                )
                              ],
                            ),
                          ), // Name
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Donations',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: style2.fontWeight,
                                        ),
                                      ),
                                      Text(
                                        "50₹",
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: style1.fontWeight,
                                        ),
                                      )
                                    ],
                                  )
                                ),
                              ],
                            ),
                          ), // Email
                        ],
                      ),
                    ),
                  ],
                ),
              ), // Body
            ],
          )),
    );
  }
}
