import 'package:dog_help_demo/Backend/FirebaseStorageManager.dart';
import 'package:dog_help_demo/Backend/FirestoreManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Item {
  const Item(this.name, this.icon);

  final String name;
  final Icon icon;
}

class SignUp extends StatefulWidget {
  final FirebaseAuth authInstance;
  final FirebaseStorage storageInstance;

  SignUp({required this.authInstance, required this.storageInstance});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<SignUp> {
  late String email;
  late String password;
  late String name;
  late String phoneNumber;
  late final FirebaseStorageManager storageManager = FirebaseStorageManager(
      storageInstance: widget.storageInstance,
      authInstance: widget.authInstance);

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _loginKey = GlobalKey<FormState>();

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

  var _name = TextEditingController(text: 'Name');
  var _email = TextEditingController(text: 'Email');
  var _password = TextEditingController(text: 'Password');
  var _phoneNo = TextEditingController(text: 'Phone Number');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.orange[900],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.60,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                        spreadRadius: 0.5,
                        offset: Offset(0, 0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.03),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.03),
                        ),
                      ),
                      Form(
                          key: _loginKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  validator: (value) {
                                    if (value!.isEmpty || value == 'Name') {
                                      return 'Please enter a valid name.';
                                    } else {
                                      name = value;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person)),
                                  style: TextStyle(color: Colors.grey),
                                  controller: _name,
                                  onTap: () {
                                    if (_name.text == 'Name') {
                                      _name.clear();
                                    }
                                  },
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty || value == 'Email') {
                                      return 'Please enter a valid email.';
                                    } else {
                                      email = value;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email)),
                                  style: TextStyle(color: Colors.grey),
                                  controller: _email,
                                  onTap: () {
                                    if (_email.text == 'Email') {
                                      _email.clear();
                                    }
                                  },
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty || value == 'Password') {
                                      return 'Please enter a valid password.';
                                    } else if (value.length < 6) {
                                      return 'Password should be at least 6 characters long';
                                    } else {
                                      password = value;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.vpn_key)),
                                  style: TextStyle(color: Colors.grey),
                                  controller: _password,
                                  onTap: () {
                                    if (_password.text == 'Password') {
                                      _password.clear();
                                    }
                                  },
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        value == 'Phone Number') {
                                      return 'Please enter a valid phone number.';
                                    } else if (value.length < 10) {
                                      return 'Please enter a valid phone number';
                                    } else {
                                      phoneNumber = value;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.phone_android)),
                                  style: TextStyle(color: Colors.grey),
                                  controller: _phoneNo,
                                  onTap: () {
                                    if (_phoneNo.text == 'Phone Number') {
                                      _phoneNo.clear();
                                    }
                                  },
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
                            ],
                          )),
                      Builder(
                        builder: (context) => Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.02),
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (_loginKey.currentState!.validate()) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    try {
                                      await widget.authInstance
                                          .createUserWithEmailAndPassword(
                                              email: email, password: password);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text('Creating Profile')));
                                      storageManager.resetProfilePicture();
                                      User user =
                                          widget.authInstance.currentUser!;
                                      user.updateProfile(
                                          displayName: name,
                                          photoURL: storageManager
                                              .profilePictureReferenceURL);
                                      FirestoreManager(
                                        name: name,
                                        userType: selectedUser!.name,
                                        phoneNo: int.parse(phoneNumber),
                                        authInstance: widget.authInstance
                                      ).addUser();
                                      Navigator.pushReplacementNamed(
                                          context, '/Login');
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
                                child: Text('Sign Up'),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.orange[900]))),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.05),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/Login');
                    },
                    child: Text(
                      "Already have an account? Login",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
