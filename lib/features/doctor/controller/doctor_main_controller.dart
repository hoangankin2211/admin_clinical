import 'dart:typed_data';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../../models/department.dart';
import '../../../models/doctor.dart';
import '../../../services/auth_service/auth_service.dart';

class DoctorMainController extends GetxController {
  RxList<Department> listDepartMent = <Department>[].obs;
  Department getDepartMent(String id, List<Department> list) =>
      list.firstWhere((element) => element.id == id);
  RxInt selectDoctor = 0.obs;
  // Text Editting controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  RxInt experince = 0.obs;
  RxString departMent = "01".obs;
  Rx<DateTime> dateBorn = DateTime.now().obs;
  RxInt gender = 0.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  // insertDoctor(
  //     VoidCallback callBack, BuildContext context, Uint8List image) async {
  //   String imageUrl = "";

  //   if (image != null) {
  //     final cloudinary = CloudinaryPublic('ddopvilpr', 'evzte9pr');
  //     CloudinaryResponse imageRes = await cloudinary.uploadFile(
  //       CloudinaryFile.fromBytesData(image, identifier: emailController.text),
  //     );
  //     imageUrl = imageRes.secureUrl;
  //   }
  //   DataService.instance.insertNewDoctor(
  //     () {},
  //     name: nameController.text,
  //     address: addressController.text,
  //     phoneNumber: phoneController.text,
  //     av: imageUrl,
  //     departMent: departMent.value,
  //     description: descriptionController.text,
  //     dateBorn: dateBorn,
  //     experience: experince.value,
  //   );
  // }

  void onInit() {
    super.onInit();
  }
}
