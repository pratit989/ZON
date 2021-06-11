import 'package:dog_help_demo/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String password;
  late String email;
  // Initially password is obscure
  bool _obscureText = true;
  IconData _icon = Icons.lock_outline;

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _loginKey = GlobalKey<FormState>();

  // var _email = TextEditingController(text: 'Email');
  // var _password = TextEditingController(text: 'Password');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.amber,
        child: Stack(
          children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.60,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
          ),
        ),
        Align(
          alignment: Alignment.center,
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
                          MediaQuery.of(context).size.height * 0.05),
                      child: Text(
                        'Login',
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
                                top: MediaQuery.of(context).size.height * 0.02,
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a valid email address.';
                                  } else {
                                    email = value;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                  hintText: 'Email'
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.02,
                              ),
                              child: TextFormField(
                                obscureText: _obscureText,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a valid password.';
                                  } else if (value.length < 6) {
                                    return 'Password should be at least 6 characters long';
                                  } else {
                                    password = value;
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
                            ),
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.05),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Builder(
                      builder: (context) => Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.04,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.04),
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_loginKey.currentState!.validate()) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: email, password: password);
                                    User user = authInstance.currentUser!;
                                    if (!user.emailVerified) {
                                      var actionCodeSettings = ActionCodeSettings(
                                        androidPackageName: "com.example.zon",
                                        androidInstallApp: true,
                                        androidMinimumVersion: "12",
                                        url: 'https://zonapp.page.link/?email=${user.email}',
                                        dynamicLinkDomain: "zonapp.page.link",
                                        handleCodeInApp: false,
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text('Processing Data')));
                                      // await user.sendEmailVerification(actionCodeSettings);
                                    }
                                    Navigator.pushReplacementNamed(
                                        context, '/Lander');
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'No user found for that email.')));
                                    } else if (e.code == 'wrong-password') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Wrong password provided for that user.')));
                                    }
                                  }
                                }
                              },
                              child: Text('Submit', style: TextStyle(color: Colors.black),),
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
                    Navigator.pushReplacementNamed(context, '/SignUp');
                  },
                  child: Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        )
          ],
        ),
      ),
    );
  }
}
