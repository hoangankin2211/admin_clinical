import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'app_colors.dart';
import 'global_widgets/custom_dialog_error/error_dialog.dart';
import 'global_widgets/custom_dialog_error/success_dialog.dart';

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

Future<String?> convertUti8ListToUrl(Uint8List? image, String name) async {
  if (image == null) return null;
  String imageUrl = "";
  final cloudinary = CloudinaryPublic('ddopvilpr', 'evzte9pr');
  CloudinaryResponse imageRes = await cloudinary.uploadFile(
    CloudinaryFile.fromBytesData(image, identifier: name),
  );
  imageUrl = imageRes.secureUrl;
  return imageUrl;
}

class Utils {
  static const spaceSizeBoxAddPatientDialog = SizedBox(height: 20);

  static Future<String?> convertAssetsToUrl(
      Uint8List? source, String identifier) async {
    if (source == null) {
      return null;
    }
    String? result;

    final cloudinary = CloudinaryPublic('ddopvilpr', 'evzte9pr');
    CloudinaryResponse imageConverter = await cloudinary.uploadFile(
      CloudinaryFile.fromBytesData(source, identifier: identifier),
    );
    result = imageConverter.secureUrl;

    return result;
  }

  static List<Map<String, dynamic>> convertList2ListMap(
      List<dynamic> source,
      Map<String, dynamic> Function(Map<String, dynamic>)
          handleExtractEachElement) {
    List<Map<String, dynamic>> result = [];

    for (var element in source) {
      Map<String, dynamic> temp = element;
      result.add(handleExtractEachElement(temp));
    }

    return result;
  }

  static Future<bool> notifyHandle({
    required bool response,
    required String successTitle,
    required String successQuestion,
    required String errorTitle,
    required String errorQuestion,
  }) async {
    if (response) {
      await Get.dialog(
        SuccessDialog(
          question: successQuestion,
          title1: successTitle,
        ),
      );
    } else {
      await Get.dialog(
        ErrorDialog(
          question: errorQuestion,
          title1: errorTitle,
        ),
      );
    }
    Get.back(result: response);
    return response;
  }

  static final List<Map<String, dynamic>> examField = [
    {
      'title': 'Clinical Examination',
      'maxLine': 4,
      'icon': Icons.checklist_rounded,
      'key': 'clinicalExamination',
    },
    {
      'title': 'Symptom',
      'maxLine': 4,
      'icon': Icons.playlist_add_check_circle_rounded,
      'key': 'symptom',
    },
    {
      'title': 'Diagnostic',
      'maxLine': 4,
      'icon': Icons.file_copy_rounded,
      'key': 'diagnostic',
    },
    {
      'title': 'Conclusion and Treatment',
      'maxLine': 4,
      'icon': Icons.confirmation_number_rounded,
      'key': 'conclusionAndTreatment',
    },
  ];

  static final List<Map<String, dynamic>> measureField = [
    {
      'title': 'Weight',
      'maxLine': 1,
      'icon': Icons.scale_outlined,
      'inputFormatters': [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*'))
      ],
      'key': 'weight',
    },
    {
      'title': 'Height',
      'maxLine': 1,
      'icon': Icons.height_rounded,
      'inputFormatter': [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*'))
      ],
      'key': 'height',
    },
    {
      'title': 'Heartbeat',
      'maxLine': 1,
      'icon': Icons.monitor_heart_rounded,
      'inputFormatters': [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*'))
      ],
      'key': 'heartBeat',
    },
    {
      'title': 'Temperature',
      'maxLine': 1,
      'icon': Icons.ac_unit_rounded,
      'inputFormatters': [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*'))
      ],
      'key': 'temperature',
    },
    {
      'title': 'BP',
      'maxLine': 1,
      'icon': Icons.bloodtype_rounded,
      'inputFormatters': [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*'))
      ],
      'key': 'bloodPressure'
    },
    {
      'title': 'Allergy',
      'maxLine': 2,
      'inputFormatters': [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*'))
      ],
      'icon': Icons.sick_rounded,
      'key': 'allergy',
    },
  ];
}
