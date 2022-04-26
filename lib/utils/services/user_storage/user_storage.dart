import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/utils/mixins/class_user_file.dart';
import 'package:zenith_monitor/utils/services/user_firestore/user_document_exceptions.dart';
import 'package:zenith_monitor/utils/services/user_storage/user_storage_exceptions.dart';

class UserStorage {
  Future<void> uploadImage() async {
    try {
      User? firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser == null) {
        throw NullUser();
      }

      LocalUser? userFile = await UserFile().readUser();
      if (userFile == null) {
        throw UserFileNotFound(); // checar se essa eh a exception correta
      }

      if (userFile.getImageLink() != null) {
        return;
      }

      String? imagePath = userFile.getImagePath();
      if (imagePath == null) return;

      final File? imageFile = File(imagePath);
      if (imageFile == null) {
        throw ImgFileNotFound();
      }

      UploadTask task = FirebaseStorage.instance
          .ref('ProfileImages/' + firebaseUser.uid.toString())
          .putFile(imageFile);
      var snapshot = await task.whenComplete(() => null);
      String imageLink = await snapshot.ref.getDownloadURL();

      userFile.setImageLink(imageLink);
      UserFile().writeUser(userFile);
    } on FirebaseException catch (e) {
      throw FirebaseProblem(isFirebaseException: true, errorMsg: e.toString());
    }
  }

  Future<File?> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) throw ImagePickerNull();

      return File(image.path);
    } on PlatformException catch (e) {
      print("erro no image picker: " + e.toString());
      return null;
    }
  }

  Future<File?> cropImage(File image) async {
    try {
      File? cropped = await ImageCropper().cropImage(
        sourcePath: image.path,
        cropStyle: CropStyle.circle,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxHeight: 700,
        maxWidth: 700,
        androidUiSettings: const AndroidUiSettings(
          toolbarColor: Colors.black,
          toolbarWidgetColor: white,
          hideBottomControls: true,
        ),
      );
      return cropped;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
