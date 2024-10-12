import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recruitment_test_website/core/utils/loggers/logger.dart';

class ImageModification {
  Future<XFile?> compressImage(XFile pickedFile) async {
    final dir = Directory.systemTemp;
    final targetPath = '${dir.absolute.path}/temp.jpg';

    final result = await FlutterImageCompress.compressAndGetFile(
      pickedFile.path,
      targetPath,
      quality: 60,
    );

    Log.debug(result!.path);
    return result;
  }

  Future<String> convertingToBase64(XFile? compressedFile) async {
    Log.debug(compressedFile.toString());
    final imageBytes = await compressedFile?.readAsBytes();
    final base64String = base64.encode(imageBytes!);

    return base64String;
  }
}
