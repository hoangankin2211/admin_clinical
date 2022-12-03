import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import 'app_colors.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.primaryColor,
      content: Text(text),
    ),
  );
}

pickFile() async {
  try {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    return File(result!.files.single.path!);
  } catch (e) {
    debugPrint("Pick image error:${e.toString()}");
  }
}

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
}

Future<String> convertUti8ListToUrl(Uint8List? image, String name) async {
  String imageUrl = "";
  final cloudinary = CloudinaryPublic('ddopvilpr', 'evzte9pr');
  CloudinaryResponse imageRes = await cloudinary.uploadFile(
    CloudinaryFile.fromBytesData(image!, identifier: name),
  );
  imageUrl = imageRes.secureUrl;
  return imageUrl;
}
