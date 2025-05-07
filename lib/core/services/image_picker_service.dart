import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<File?> pickImageOFCamera() async {
    File? imagePicker;
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );
    if (image != null) {
      imagePicker = File(image.path);
    }
    return imagePicker;
  }

  static Future<File?> pickImageOFGallary() async {
    File? imagePicker;
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      imagePicker = File(image.path);
    }
    return imagePicker;
  }

  static Future<List<File?>> pickMultibleImage() async {
    try {
      List<File> imagePicker = [];
      final List<XFile> images = await _imagePicker.pickMultiImage();
      if (images.isNotEmpty) {
        for (XFile image in images) {
          imagePicker.add(File(image.path));
        }
      }
      return imagePicker;
    } catch (e) {
      // getItInstance<Logger>().e("Error message : $e");
      throw Exception(e);
    }
  }

// you can add video,audio or multible audio functios
}
