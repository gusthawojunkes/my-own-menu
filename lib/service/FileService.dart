import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FileServive {
  static Future<firebase_storage.UploadTask?> uploadFile(
      String repository, XFile file) async {
    firebase_storage.UploadTask uploadTask;

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child(repository)
        .child("/" + file.name);

    final metadata = firebase_storage.SettableMetadata(
        customMetadata: {'picked-file-path': file.path});

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(io.File(file.path), metadata);
    }

    return Future.value(uploadTask);
  }

  // static Future<firebase_storage.ListResult?> downloadFile(
  //     String repository) async {
  //   firebase_storage.Reference ref =
  //       firebase_storage.FirebaseStorage.instance.ref().child(repository);
  //   Future<firebase_storage.ListResult> imagens = ref.list();

  //   return imagens;
  // }

  static downloadFile(String repository) async {
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref().child(repository);

    ref.listAll().then((res) {
      res.prefixes.forEach((folderRef) {});
      res.items.forEach((itemRef) async {
        print('itemRef: ' + itemRef.toString());
        final downloadURL = await itemRef.getDownloadURL();
        print('downloadURL: ' + downloadURL.toString());
      });
    });

    return ref;
  }
}
