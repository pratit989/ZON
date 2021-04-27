import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirestoreManager {
  final String? name;
  final String? userType;
  final int? phoneNo;
  final FirebaseAuth authInstance;

  FirestoreManager({this.name, this.userType, this.phoneNo, required this.authInstance});

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users.doc(authInstance.currentUser!.uid)
        .set({
          'name': name, // Pratit
          'user_type': userType, // Hero or NGO
          'phone_no': phoneNo // 7728472965
        })
        .then((value) => print("User Added"))
        .catchError((error) {
      print("Failed to add user: $error");
      authInstance.currentUser!.delete();
    });
  }

  Future<Map<String, dynamic>?> getUserData () async {
    Map<String, dynamic>? data;

    await users
        .doc(authInstance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        data = documentSnapshot.data();
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
    });

    return data;
  }
}
