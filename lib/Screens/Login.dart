import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _loginKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.orange[900],
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.9,
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
                        padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.05),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: MediaQuery.of(context).size.height*0.03
                          ),
                        ),
                      ),
                      Form(
                        key: _loginKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.8,
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height*0.02,
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if(value.isEmpty) {
                                    return 'Please enter a valid email address.';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email)
                                ),
                                style: TextStyle(
                                  color: Colors.grey
                                ),
                                initialValue: 'Email',
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.8,
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height*0.02,
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if(value.isEmpty) {
                                    return 'Please enter a valid password.';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.vpn_key)
                                ),
                                style: TextStyle(
                                    color: Colors.grey
                                ),
                                initialValue: 'Password',
                              ),
                            ),
                          ],
                        )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot Password',
                                style: TextStyle(
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Builder(
                        builder: (context) =>
                            Padding(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04, bottom: MediaQuery.of(context).size.height*0.04),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_loginKey.currentState.validate()) {
                                    Scaffold.of(context)
                                        .showSnackBar(SnackBar(content: Text('Processing Data')));
                                    Navigator.pushReplacementNamed(context, '/Home');
                                  }
                                },
                                child: Text('Submit'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.orange[900]
                                )
                              )
                            ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/SignUp');
                    },
                    child: Text(
                      "Don't have an account? Sign up",
                      style: TextStyle(
                          color: Colors.black
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ),
    );
  }
}
