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


  Future<List<XFile>> pickMultiImage({
    required ImageSource source,
  }) async {
    final images = await picker.pickMultiImage(
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 70,
      limit: 6,
      requestFullMetadata: true,
    );
    return images;
  }

}
