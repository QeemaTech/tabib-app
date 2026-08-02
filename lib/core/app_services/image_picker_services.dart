import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';


@injectable
class ImagePickerServices {
  final ImagePicker picker = ImagePicker();

  Future<XFile?> pickImage({ImageSource source = ImageSource.gallery}) async {
    try {
      final XFile? image = await picker.pickImage(
        source: source,
        imageQuality: 80,
      );
      return image;
    } catch (e) {
      return null;
    }
  }

}
