import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
// Users Collection
CollectionReference users = db.collection('users');
// Rescue Collection
CollectionReference rescue = db.collection('rescue');
// Saved Collection
CollectionReference saved = db.collection('saved');
// Chat Collection
CollectionReference chat = db.collection('chat');
// Notifications Collection
CollectionReference notifications = db.collection('notifications');

class FirestoreManager {

  Future<void> addUser(
      {
        required String email,
        required String name,
        required String userType,
        required int phoneNo,
        String? city,
        String? state,
        String? typeOfNGO,
        String? registrationNo,
        String? website,
      }) {
    // Call the user's CollectionReference to add a new user
    return users.doc(authInstance.currentUser!.uid)
        .set({
          'name': name, // Pratit
          'user_type': userType, // Hero or NGO
          'phone_no': phoneNo // 7728472965
        })
        .then((value) async => {
          print("User Added"),
          if (userType == 'NGO') {
            await users
                .doc('ngoList')
                .set({
              name.toString():name.toString()
            }, SetOptions(merge: true))
          },
        })
        .catchError((error) {
      print("Failed to add user data: $error");
    });
  }

  Future<void> writeDocToCollection(CollectionReference collectionReference, String documentName, Map<String, dynamic> map) {
    // Call the user's CollectionReference to add data
    return collectionReference.doc(documentName)
        .set(map, SetOptions(merge: true))
        .then((value) async => {
      print("Data added to $documentName in $collectionReference"),
    }).catchError((error) {
      print("Failed to add user data: $error");
    });
  }

  Future<Map<String, dynamic>?> readDocFromCollection(CollectionReference collectionReference, String documentName) async {
    Map<String, dynamic>? data;

    await collectionReference
        .doc(documentName)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        data = documentSnapshot.data() as Map<String, dynamic>?;
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
    });

    return data;
  }

  Future<Map<String, dynamic>?> getUserData () async {
    Map<String, dynamic>? data;

    await users
        .doc(authInstance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        data = documentSnapshot.data() as Map<String, dynamic>?;
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
    });

    return data;
  }

  void getKeysFromMap(Map<String, dynamic> map, List<String> list) {
    // Get all keys
    map.keys.forEach((key) {
      list.add(key);
    });
  }

  Future<void> getNgoSearchList() async {
    ngoNamesList = [];
    await users.doc('ngoList').get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic>? ngoData = documentSnapshot.data() as Map<String, dynamic>?;
        getKeysFromMap(ngoData!, ngoNamesList);
      } else {
        print('Document does not exist on the database');
      }
    });
  }
}
