import 'package:flutter/material.dart';

import '../main.dart';
import '../Screens/Home.dart';
import '../Screens/ProfilePicture.dart';
class MyDrawer extends StatefulWidget {

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = true;
  bool _error = false;


  void initializeProfile() async {
    try {
      // Wait to get Download URl for Profile Picture
      profileURL = await storageManager.getDownloadURL(storageManager.profilePictureReferenceURL);
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
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return Text('Something went wrong');
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Container();
    }

    return Drawer(
      child: Container(
        color: Color.fromRGBO(12, 10, 10, 1.0),
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
                        await Navigator.pushNamed(
                            context, ExtractArguments.routeName,
                            arguments: PictureDisplay(
                              auth: authInstance,
                              storage: storageInstance,
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
                            authInstance.currentUser!.displayName!,
                            style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.w500,
                              fontSize:
                              MediaQuery.of(context).size.width * 0.08,
                            ),
                          ),
                          Text(
                            data!['user_type'],
                            style: TextStyle(
                                color: Colors.white,
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
                          Navigator.pushReplacementNamed(context, '/Home');
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
                        onPressed: () async {
                          Navigator.pop(context);
                          await Navigator.pushNamed(context, '/Camera');
                        },
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        icon: Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Save a Life',
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
                          Navigator.pop(context);
                          await Navigator.pushNamed(context, '/ProfilePage');
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
                    FloatingActionButton.extended(
                        heroTag: 'NGOHome',
                        onPressed: () async {
                          Navigator.pop(context);
                          await Navigator.pushNamed(context, '/NGOHome');
                        },
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        icon: Icon(
                          Icons.trip_origin,
                          color: Colors.white,
                        ),
                        label: Text(
                          'NGO',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                ),
                Row(
                  children: [
                    FloatingActionButton.extended(
                        onPressed: () async {
                          await authInstance.signOut();
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
    );
  }
}
