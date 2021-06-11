import 'package:dog_help_demo/Backend/FirebaseStorageManager.dart';
import 'package:dog_help_demo/Widgets/UserDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';
import 'ProfilePicture.dart';

class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

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
          .getDownloadURL(profilePictureReferenceURL);
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
      return Center(child: CircularProgressIndicator(color: Colors.amber));
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                top: MediaQuery.of(context).size.height * 0.08,
                              ),
                              child: Text(
                                  authInstance.currentUser!.displayName!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Edit Profile Button
                        Padding(
                          padding: EdgeInsets.only(
                            left: (MediaQuery.of(context).size.width-220)/2
                          ),
                          child: TextButton(
                            onPressed: () async{
                              await Navigator.pushNamed(context, '/EditProfile').then((_) => {
                                _initialized = false,
                                setState(() {
                                  initializeProfile();
                                }),
                              });
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.black54),
                                fixedSize: MaterialStateProperty.all(Size(100, 10)),
                                elevation: MaterialStateProperty.all(20),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                                ),
                                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.hovered))
                                      return Colors.black54.withOpacity(0.04);
                                    if (states.contains(MaterialState.focused) ||
                                        states.contains(MaterialState.pressed))
                                      return Colors.black54.withOpacity(0.12);
                                    return null; // Defer to the widget's default.
                                  },
                                ),
                            ),
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
                        // Data
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
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
                                  authInstance.currentUser!.email!,
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
                        ),
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
                          height: MediaQuery.of(context).size.height/5.5,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30
                                ),
                                child: Text(
                                  0.toString(),
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
                          height: MediaQuery.of(context).size.height/5.5,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30
                                ),
                                child: Text(
                                  0.toString(),
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
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))
                ),
                elevation: MaterialStateProperty.all<double>(40),
                fixedSize: MaterialStateProperty.all<Size>(Size(MediaQuery.of(context).size.height * 0.2, MediaQuery.of(context).size.height * 0.2))
              ),
              onPressed: () async {
                print('tapped');
                await Navigator.pushNamed(context, ExtractArguments.routeName,
                    arguments: PictureDisplay(
                      auth: authInstance,
                      storage: storageInstance,
                ));
                initializeProfile();
                setState(() {});},
              child : CircleAvatar(
                backgroundColor: Colors.black,
                radius: MediaQuery.of(context).size.height * 0.1,
                backgroundImage: NetworkImage(profileURL),
              ),
            ),
          )
        ],
      ),
    );
  }
}
