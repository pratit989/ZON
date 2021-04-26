import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddUser {
  final String name;
  final String userType;
  final int phoneNo;
  final FirebaseAuth authInstance;

  AddUser(this.name, this.userType, this.phoneNo, this.authInstance);

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
}
