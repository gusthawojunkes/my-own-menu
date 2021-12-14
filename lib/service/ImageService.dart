import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImageService {
  static Future<XFile?> getImage() async {
    ImagePicker picker = ImagePicker();

    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  static Future<String> downloadFile(String repository) async {
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref().child(repository);
    String downloadURL = "";
    ref.listAll().then((res) {
      res.prefixes.forEach((folderRef) {});
      res.items.forEach((itemRef) async {
        print('itemRef: ' + itemRef.toString());
        downloadURL = await itemRef.getDownloadURL();
        print('downloadURL: ' + downloadURL);
      });
    });

    return downloadURL;
  }
}
