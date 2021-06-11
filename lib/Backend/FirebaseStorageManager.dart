import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:dog_help_demo/Backend/FileManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

import '../main.dart';

final FileManagement fileManager = FileManagement();

var uid = Uuid();
// Regularly Used Constants
late String rootReferenceURL = 'gs://${FirebaseStorage.instance.bucket}';
late String profilePictureReferenceURL = 'users/' + authInstance.currentUser!.uid + '/1p.jpg';
late String rescueRequestsReferenceURL = 'rescue/' + uid.v4() + authInstance.currentUser!.uid + '_animal.jpg';
late String savedReferenceURL = 'saved/' + uid.v4() + authInstance.currentUser!.uid + '_animal.jpg';

void updateReferences(String uuid) {
  profilePictureReferenceURL = 'users/' + authInstance.currentUser!.uid + '/1p.jpg';
  rescueRequestsReferenceURL = 'rescue/' + uuid + authInstance.currentUser!.uid + '_animal.jpg';
  savedReferenceURL = 'saved/' + uuid + authInstance.currentUser!.uid + '_animal.jpg';
}

class FirebaseStorageManager {

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