import 'package:dog_help_demo/Backend/FirebaseStorageManager.dart';
import 'package:dog_help_demo/Backend/FirestoreManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Item {
  const Item(this.name, this.icon);

  final String name;
  final Icon icon;
}

class SignUp extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<SignUp> {
  List<String> fieldNames = [
    'Name',
    'Phone Number',
    'Email',
    'Password',
    'City',
    'State',
    'Type of NGO',
    'Registration No',
    'Website URL',
  ];
  List<IconData> icons = [
    Icons.person,
    Icons.phone_android,
    Icons.email,
    Icons.vpn_key,
    Icons.location_city,
    Icons.account_balance,
    Icons.group,
    Icons.app_registration,
    Icons.link
  ];
  int formFieldCount = 4;
  Map<String,String> formData = {
    'Name': '',
    'Phone Number': '',
    'Email': '',
    'Password': '',
    'City': '',
    'State': '',
    'Type of NGO': '',
    'Registration No': '',
    'Website URL': '',
  };
  // Initially password is obscure
  bool _obscureText = true;
  IconData _icon = Icons.lock_outline;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.amber,
        child: Stack(
          children: [
            Transform.translate(
              offset: Offset(0, MediaQuery.of(context).size.height * 0.4),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50))),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
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
                              Form(
                                  key: _loginKey,
                                  child: SingleChildScrollView(
                                    physics: ScrollPhysics(),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
                                          child: Text(
                                            'Sign Up',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize:
                                                MediaQuery.of(context).size.height * 0.03),
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
                                                formData['Type'] = value!.name;
                                                selectedUser = value;
                                                if (value == users[1]){
                                                  formFieldCount = fieldNames.length;
                                                } else if (value == users[0]){
                                                  formFieldCount = 4;
                                                }
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
                                        ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: formFieldCount,
                                            itemBuilder: (context,index){
                                              if (fieldNames[index] != 'Password') {
                                                return Container(
                                                  width: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width * 0.8,
                                                  padding: EdgeInsets.only(
                                                    top:
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height * 0.02,
                                                  ),
                                                  child: TextFormField(
                                                    textCapitalization: TextCapitalization
                                                        .words,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Please enter a valid name.';
                                                      } else {
                                                        formData[fieldNames[index]] =
                                                            value;
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                      prefixIcon: Icon(
                                                          icons[index]),
                                                      hintText: fieldNames[index],
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return Container(
                                                  width: MediaQuery.of(context).size.width * 0.8,
                                                  padding: EdgeInsets.only(
                                                    top:
                                                    MediaQuery.of(context).size.height * 0.02,
                                                  ),
                                                  child: TextFormField(
                                                    obscureText: _obscureText,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Please enter a valid password.';
                                                      } else if (value.length < 6) {
                                                        return 'Password should be at least 6 characters long';
                                                      } else {
                                                        formData[fieldNames[index]] = value;
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                        prefixIcon: Icon(Icons.vpn_key),
                                                        suffixIcon: IconButton(
                                                          icon: Icon(_icon),
                                                          onPressed: () {
                                                            if(_obscureText){
                                                              _obscureText = false;
                                                              _icon = Icons.lock_open;
                                                            } else {
                                                              _obscureText = true;
                                                              _icon = Icons.lock_outline;
                                                            }
                                                            setState(() {});
                                                          },
                                                        ),
                                                        hintText: 'Password'
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          padding: EdgeInsets.symmetric(horizontal: 20),
                                        )
                                      ],
                                    ),
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
                                              await authInstance
                                                  .createUserWithEmailAndPassword(
                                                  email: formData['Email']!, password: formData['Password']!);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                  content:
                                                  Text('Creating Profile')));
                                              await storageManager.resetProfilePicture();
                                              User user =
                                              authInstance.currentUser!;
                                              user.updateDisplayName(formData['Name']!);
                                              user.updatePhotoURL(profilePictureReferenceURL);
                                              try {
                                                FirestoreManager().addUser(
                                                  userType: selectedUser!.name,
                                                  name: formData['Name']!,
                                                  phoneNo: int.parse(formData['Phone Number']!),
                                                  email: formData['Email']!,
                                                  city: formData['City'],
                                                  state: formData['State'],
                                                  typeOfNGO: formData['Type of NGO'],
                                                  registrationNo: formData['Registration No'],
                                                  website: formData['Website URL'],
                                                );
                                                // if (!user.emailVerified) {
                                                //   var actionCodeSettings = ActionCodeSettings(
                                                //     androidPackageName: "com.example.zon",
                                                //     androidInstallApp: true,
                                                //     androidMinimumVersion: "12",
                                                //     url: 'https://zonapp.page.link/?email=${user.email}',
                                                //     dynamicLinkDomain: "zonapp.page.link",
                                                //     handleCodeInApp: false,
                                                //   );
                                                Navigator.pushReplacementNamed(context, '/CheckEmail');
                                                // user.sendEmailVerification(actionCodeSettings).then((value) =>
                                                // {
                                                //   Navigator.pushReplacementNamed(context, '/CheckEmail')
                                                // });
                                                // }
                                              } catch (error) {
                                                print("Failed to add user: $error");
                                                authInstance.currentUser!.delete();
                                              }
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
                                        child: Text('Sign Up', style: TextStyle(color: Colors.black),),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.amber))),
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
