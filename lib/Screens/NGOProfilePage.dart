import 'package:dog_help_demo/Backend/FirebaseStorageManager.dart';
import 'package:dog_help_demo/Screens/NGOProfileEditPage.dart';
import 'package:dog_help_demo/main.dart';
import 'package:flutter/material.dart';


class NGOProfilePage extends StatefulWidget {
  const NGOProfilePage({Key? key}) : super(key: key);

  @override
  _NGOProfilePageState createState() => _NGOProfilePageState();
}

class _NGOProfilePageState extends State<NGOProfilePage> {

  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to get Download URL for Profile Picture
  void initializeProfile() async {
    try {
      // Wait to get Download URl for Profile Picture
      profileURL = await storageManager
          .getDownloadURL(profilePictureReferenceURL);
      firestoreUserData = await firestoreManager.getUserData();
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

  TextStyle dataName = TextStyle(
      color: Colors.black26,
      fontWeight: FontWeight.w800,
      fontSize: 15
  );
  TextStyle userData = TextStyle();
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
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        centerTitle: true,
        title: Text(authInstance.currentUser!.displayName!),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/3,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                      profileURL,
                      fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(-0.0, -0.0), //(x,y)
                          blurRadius: 20.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(authInstance.currentUser!.displayName!,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextButton(
                            onPressed: () async{
                              Navigator.push(context, MaterialPageRoute(builder: (context) => NGOProfileEditPage())).then((_) => {
                                _initialized = false,
                                setState(() {}),
                                initializeProfile(),
                                setState(() {}),
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.black54),
                              fixedSize: MaterialStateProperty.all(Size(100, 10)),
                              elevation: MaterialStateProperty.all(10),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text('MMA 14 1/1, B.S.S.R.S, Ghatla, Chembur, Mumbai - 71',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('50', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),),
                                        Text('Total Donations', style: TextStyle(fontSize: 20),)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('10', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),),
                                        Text('Dogs Saved', style: TextStyle(fontSize: 20),)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: const Divider(
                              height: 20,
                              thickness: 2,
                              indent: 10,
                              endIndent: 10,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Save A Life: ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 25),),
                      Text('Contact Us ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 15),),
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
                              firestoreUserData!['phone_no'].toString(),
                              style: userData,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}
