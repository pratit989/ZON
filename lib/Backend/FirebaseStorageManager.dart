import 'dart:io';

import 'package:dog_help_demo/Backend/FileManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseStorageManager {
  final FirebaseStorage storageInstance; // Required Firebase Storage Instance
  final FirebaseAuth? authInstance;  // Optional Firebase Authentication Instance
  final FileManagement fileManager = FileManagement();

  // Regularly Used Constants
  late final String profilePictureReferenceURL = 'users/' + authInstance!.currentUser!.uid + '/1p.jpg';

  // Class Initializer
  FirebaseStorageManager({required this.storageInstance, this.authInstance});

  Future<String> getDownloadURL(String referenceURL) async{
    return await storageInstance
        .ref(referenceURL)
        .getDownloadURL();
  }

  void uploadFile(String referenceUrl, File uploadFile) async{
    await storageInstance
        .ref(referenceUrl)
        .putFile(uploadFile);
  }

  Future<void> resetProfilePicture() async {
    try {
      uploadFile(
          profilePictureReferenceURL,
          await fileManager.compressFile(
              await fileManager.getImageFileFromAssets('1p.jpg')));
    } on FirebaseException catch (e) {print(e);}
  }
}