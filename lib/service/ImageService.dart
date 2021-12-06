import 'package:image_picker/image_picker.dart';

class ImageService {
  static Future<XFile?> getImage() async {
    ImagePicker picker = ImagePicker();

    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }
}
