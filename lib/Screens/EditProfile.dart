import 'package:dog_help_demo/Backend/FirebaseStorageManager.dart';
import 'package:dog_help_demo/Backend/FirestoreManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'ProfilePicture.dart';
import 'SignUp.dart';

class EditProfileData extends StatefulWidget {

  @override
  _EditProfileDataState createState() => _EditProfileDataState();
}

class _EditProfileDataState extends State<EditProfileData> {
  late String email;
  late String password;
  late String name;
  late String phoneNumber;

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _editKey = GlobalKey<FormState>();

  Item? selectedUser;
  List<Item> users = <Item>[
    const Item(
        'Hero',
        Icon(
          Icons.person,
          color: Colors.grey,
        )),
    const Item(
        'NGO',
        Icon(
          Icons.corporate_fare,
          color: Colors.grey,
        )),
  ];

  var _name = TextEditingController(text: authInstance.currentUser!.displayName!);
  var _email = TextEditingController(text: authInstance.currentUser!.email!);
  var _password = TextEditingController(text: 'Password');
  late var _phoneNo = TextEditingController(text: data!['phone_no'].toString());

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
      if (data!['user_type'] == 'Hero') {
        selectedUser = users[0];
      } else {
        selectedUser = users[1];
      }
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
      return Center(child: CircularProgressIndicator(color: Colors.amber,));
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.amber,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height/6,
                  left: 20,
                  right: 20,
                  bottom: 5
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                          // Data
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 5
                            ),
                            child: Form(
                              key: _editKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height * 0.08,
                                    ),
                                    child: Text(
                                      'Name',
                                      style: dataName,
                                    ),
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty || value == 'Name') {
                                        return 'Please enter a valid email.';
                                      } else {
                                        name = value;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.drive_file_rename_outline)),
                                    controller: _name,
                                    onTap: () {
                                      if (_name.text == authInstance.currentUser!.displayName!) {
                                        _name.clear();
                                      }
                                    },
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30,
                                        bottom: 8
                                    ),
                                    child: Text(
                                      'Email Address',
                                      style: dataName,
                                    ),
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty || value == 'Email' || !value.contains('@')) {
                                        return 'Please enter a valid email.';
                                      } else {
                                        email = value;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.email)),
                                    style: userData,
                                    controller: _email,
                                    onTap: () {
                                      if (_email.text == authInstance.currentUser!.email!) {
                                        _email.clear();
                                      }
                                    },
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
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty || value == 'Phone Number') {
                                        return 'Please enter a valid email.';
                                      } else {
                                        phoneNumber = value;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.phone)),
                                    style: userData,
                                    controller: _phoneNo,
                                    onTap: () {
                                      if (_phoneNo.text == data!['phone_no'].toString()) {
                                        _phoneNo.clear();
                                      }
                                    },
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
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    padding: EdgeInsets.only(
                                      top:
                                      MediaQuery.of(context).size.height * 0.02,
                                    ),
                                    child: DropdownButtonFormField<Item>(
                                      validator: (value) =>
                                      value == null ? 'field required' : null,
                                      isExpanded: true,
                                      hint: Text("Select User Type"),
                                      value: selectedUser,
                                      onChanged: (Item? value) {
                                        setState(() {
                                          selectedUser = value!;
                                        });
                                      },
                                      items: users.map((Item user) {
                                        return DropdownMenuItem<Item>(
                                          value: user,
                                          child: Row(
                                            children: <Widget>[
                                              user.icon,
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                user.name,
                                                style:
                                                TextStyle(color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  // Submit Changes Button
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Center(
                                      child: TextButton(
                                        onPressed: () async {
                                          if (_editKey.currentState!.validate()) {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            try {
                                              storageManager.resetProfilePicture();
                                              User user = authInstance.currentUser!;
                                              user.updateDisplayName(name);
                                              user.updateEmail(email);
                                              FirestoreManager().addUser(
                                                email: email,
                                                name: name,
                                                userType: selectedUser!.name,
                                                phoneNo: int.parse(phoneNumber),
                                              );
                                              Navigator.pop(context);
                                            } on FirebaseAuthException catch (e) {
                                              if (e.code == 'weak-password') {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'The password provided is too weak.')));
                                              } else if (e.code ==
                                                  'email-already-in-use') {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'The account already exists for that email.')));
                                              }
                                            } catch (e) {
                                              print(e);
                                            }
                                          }
                                        },
                                        style: ButtonStyle(
                                          fixedSize: MaterialStateProperty.all(Size(100,10)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                                          ),
                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.black54),
                                          overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                                (Set<MaterialState> states) {
                                              if (states.contains(MaterialState.hovered))
                                                return Colors.transparent.withOpacity(0.04);
                                              if (states.contains(MaterialState.focused) ||
                                                  states.contains(MaterialState.pressed))
                                                return Colors.transparent.withOpacity(0.12);
                                              return null; // Defer to the widget's default.
                                            },
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.done,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              'Submit',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Delete Profile Button
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => OptionsDialogueBox()));
                              },
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(Size(110,10)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                                ),
                                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.hovered))
                                      return Colors.transparent.withOpacity(0.04);
                                    if (states.contains(MaterialState.focused) ||
                                        states.contains(MaterialState.pressed))
                                      return Colors.transparent.withOpacity(0.12);
                                    return null; // Defer to the widget's default.
                                  },
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.delete_forever,
                                    size: 15,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    'Delete Profile',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 13
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: Offset(
                  (MediaQuery.of(context).size.width - (MediaQuery.of(context).size.height * 0.1)*2)/2,
                  (MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.1)*2)/12
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
                  radius: MediaQuery.of(context).size.height * 0.1,
                  backgroundColor: Colors.black,
                  backgroundImage: NetworkImage(profileURL),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OptionsDialogueBox extends StatelessWidget {
  const OptionsDialogueBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Warning!'),
      ),
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'This will permanently delete your account.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(onPressed: () {Navigator.pop(context, 'Yes');}, child: Text('Yes')),
                  TextButton(onPressed: () {Navigator.pop(context, 'No');}, child: Text('No')),
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}

