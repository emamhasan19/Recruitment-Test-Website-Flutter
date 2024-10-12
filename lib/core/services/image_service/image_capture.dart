import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:recruitment_test_website/core/services/image_service/image_modification.dart';
import 'package:recruitment_test_website/core/utils/loggers/logger.dart';

class ImageCapture {
  String convertedBase64String = '';
  String? errorMessage;
  String? errorTittle;
  bool largeImage = false;

  Future<String?> getImageFromGallery() async {
    if (Platform.isIOS) {
      final pickedFile = await _pickImageFromGallery();
      return _processImage(pickedFile!);
    }

    final permission = await _getMediaLibraryPermission();
    if (!permission) return null;

    final pickedFile = await _pickImageFromGallery();
    if (pickedFile == null) return null;

    return _processImage(pickedFile);
  }

  Future<String?> getImageFromCamera() async {
    if (Platform.isIOS) {
      final pickedFile = await _pickImageFromCamera();
      return _processImage(pickedFile!);
    }

    final permission = await _getCameraPermission();
    if (!permission) return null;

    final pickedFile = await _pickImageFromCamera();
    if (pickedFile == null) return null;

    return _processImage(pickedFile);
  }

  Future<bool> _getMediaLibraryPermission() async {
    final status = await Permission.mediaLibrary.status;

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      errorTittle = 'Permission is required';
      errorMessage = 'You cannot select an image without giving access';
      return false;
    }

    final result = await Permission.mediaLibrary.request();

    return result.isGranted;
  }

  Future<bool> _getCameraPermission() async {
    final status = await Permission.camera.status;
    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      errorTittle = 'Permission is required';
      errorMessage = 'You cannot select an image without giving access';
      return false;
    }

    final result = await Permission.camera.request();
    return result.isGranted;
  }

  Future<XFile?> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 600,
      maxWidth: 800,
    );
    return pickedFile;
  }

  Future<XFile?> _pickImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 600,
      maxWidth: 800,
    );
    return pickedFile;
  }

  Future<String?> _processImage(XFile pickedFile) async {
    var fileBytes = await pickedFile.readAsBytes();
    var sizeInBytes = fileBytes.length;
    var sizeInKB = sizeInBytes / 1024;

    final imageModification = ImageModification();

    Log.debug(sizeInKB.toString());
    if (sizeInKB > 100) {
      pickedFile = (await imageModification.compressImage(pickedFile))!;

      fileBytes = await pickedFile.readAsBytes();
      sizeInBytes = fileBytes.length;
      sizeInKB = sizeInBytes / 1024;
    }
    if (sizeInKB > 100) {
      errorTittle = 'Large Image !!';
      errorMessage = 'Try Using Image below 2MB';
      largeImage = true;
    } else {
      convertedBase64String =
          await imageModification.convertingToBase64(pickedFile);
    }

    return convertedBase64String;
  }
}
