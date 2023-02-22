import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Functions {
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImage({required File image, required uid}) async {
    Reference reference = _firebaseStorage.ref().child("profiles").child(uid);
    UploadTask uploadTask =
        reference.putFile(image, SettableMetadata(contentType: "image/jpg"));

    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
