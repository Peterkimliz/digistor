import 'dart:io';

import 'package:digi_store/controllers/auth_controller.dart';
import 'package:digi_store/services/users.dart';
import 'package:digi_store/utils/fuctions.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user.dart';

class UserController extends GetxController {
  RxBool loadingUser = RxBool(false);

  File? image;
  RxString imagePath = RxString("");
  final _picker = ImagePicker();
  Future<void> getImage({required type}) async {
    final pickedFile = await _picker.getImage(
        source: type == "camera" ? ImageSource.camera : ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      imagePath.value = pickedFile.path;
      var downloadUrl = await Functions().uploadImage(
          image: image!,
          uid: Get.find<AuthController>().currentUser.value!.id!);
      updateUserById(
          uid: Get.find<AuthController>().currentUser.value!.id!,
          body: {"profileImage": downloadUrl});
    } else {
      print('No image selected.');
    }
  }

  getUserById(String uid) async {
    try {
      var response = await Users().getUserById(uid: uid);
      print(response);
      if (response["message"] != null) {
      } else {
        User user = User.fromJson(response);
        Get.find<AuthController>().currentUser.value = user;
        Get.find<AuthController>().currentUser.refresh();
      }
    } catch (e) {
      print(e);
    }
  }

  updateUserById(
      {required String uid, required Map<String, dynamic> body}) async {
    try {
      var response = await Users().updateUser(uid: uid, body: body);
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
