import 'package:dog_help_demo/Backend/FirebaseStorageManager.dart';
import 'package:dog_help_demo/Backend/FirestoreManager.dart';
import 'package:dog_help_demo/Screens/Camera.dart';
import 'package:dog_help_demo/main.dart';
import 'package:flutter/material.dart';
import 'dart:io';

String? _dogName = '';
String? _address = '';
String? _description = '';

class SubmitAnimalProfile extends StatefulWidget {
  @override
  _AnimalHelpState createState() => _AnimalHelpState();
}

class _AnimalHelpState extends State<SubmitAnimalProfile> {
  final _animalEditKey = GlobalKey<FormState>();

  late double dataBoxWidth = MediaQuery.of(context).size.width*0.18;
  late double dataBoxHeight = dataBoxWidth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                child: Image.file(File(imagePath!), fit: BoxFit.fill,),
              ),
              Form(
                key: _animalEditKey,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.4,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: TextFormField(
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context).size.height*0.04,
                                              fontWeight: FontWeight.w900
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              print("Please enter a some value");
                                            } else {
                                              _dogName = value;
                                            }
                                          },
                                          decoration: InputDecoration(hintText: 'Description'),
                                        ),
                                        width: MediaQuery.of(context).size.width/1.4,
                                      ),
                                      Container(
                                        child: TextFormField(
                                          initialValue: location,
                                          style: TextStyle(
                                            color: Colors.grey[400],
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              print("Please enter your current address location");
                                            } else {
                                              _address = value;
                                            }
                                          },
                                          decoration: InputDecoration(hintText: 'Location'),
                                        ),
                                        width: MediaQuery.of(context).size.width/1.4,
                                      )
                                    ],
                                  ),
                                  IconButton(
                                    iconSize: MediaQuery.of(context).size.width*0.12,
                                    icon: Icon(
                                      Icons.assignment_ind,
                                      color: Colors.amber,
                                    ),
                                    onPressed: () {},
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height*0.2,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                                color: Colors.black87
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () async {
                                      if (_animalEditKey.currentState!.validate()) {
                                        FocusScope.of(context).requestFocus(FocusNode());
                                        String url = rescueRequestsReferenceURL;
                                        try {
                                          storageManager.uploadFile(
                                              rescueRequestsReferenceURL,
                                              await fileManager.compressFile(File(imagePath!)));
                                          await firestoreManager.writeDocToCollection(rescue, 'list', {url:url});
                                          await firestoreManager.writeDocToCollection(rescue, url.replaceFirst("rescue/", ""),
                                              {
                                                'Name':_dogName,
                                                'Address': _address,
                                                'Description': _description,
                                                'User': authInstance.currentUser!.displayName,
                                                'UID' : authInstance.currentUser!.uid,
                                                'Url': url,
                                          });
                                          Navigator.popUntil(context, (route) => route.isFirst);
                                        } catch (error) {print("$error while in SubmitAnimalProfile.dart");}
                                      }
                                    },
                                    child: Text(
                                      'Submit Rescue Request',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width*0.05,
                                          color: Colors.black
                                      ),
                                    ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.amber)
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}