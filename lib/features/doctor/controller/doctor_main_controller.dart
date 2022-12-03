import 'dart:typed_data';

import 'package:admin_clinical/constants/global_widgets/custom_dialog_error/error_dialog.dart';
import 'package:admin_clinical/constants/global_widgets/custom_dialog_error/success_dialog.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/department.dart';
import '../../../models/doctor.dart';
import '../../../services/data_service/data_service.dart';

class DoctorMainController extends GetxController {
  RxList<Department> listDepartMent = <Department>[].obs;
  RxList<Doctor1> listDoctor = <Doctor1>[].obs;
  RxList<Doctor1> listSearchDoctor = <Doctor1>[].obs;

  @override
  void onInit() {
    super.onInit();
    listDepartMent.value = DataService.instance.listDepartMent.value;
    listDoctor.value = DataService.instance.listDoctor.value;
    update(['listDoctor']);
  }

  Department getDepartMent(String id, List<Department> list) =>
      list.firstWhere((element) => element.id == id);
  RxInt selectDoctor = 0.obs;
  // Text Editting controller
  final TextEditingController searchController = TextEditingController();

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

  RxInt selectDepartMent = 0.obs;

  fetchSearchDoctor(BuildContext context, String searchQuery) async {
    if (searchQuery != "") {
      listSearchDoctor.value =
          await DataService.instance.searchDoctor(context, searchQuery);
    } else {
      listSearchDoctor.value.clear();
    }
    update(['listDoctor']);
  }

  deleteDoctor(BuildContext context, String id) async {
    DataService.instance.deleteDoctor(context, (value) {
      listDoctor.value = value;
      showDialog(
        context: context,
        builder: (context) => const SuccessDialog(
            question: "Delete new Doctor", title1: "Sucess"),
      );
      selectDoctor.value = 0;
      update(['listDoctor']);
    }, id: id);
  }

  insertDoctor(BuildContext context, Uint8List? image) async {
    if (nameController.text == "" ||
        addressController.text == "" ||
        phoneController.text == "" ||
        emailController.text == "" ||
        passController.text == "") {
      await showDialog(
        context: context,
        builder: (context) =>
            const ErrorDialog(question: "Insert new Doctor", title1: "Failed"),
      );
    } else {
      String imageUrl = "";
      final cloudinary = CloudinaryPublic('ddopvilpr', 'evzte9pr');
      CloudinaryResponse imageRes = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(image!, identifier: emailController.text),
      );
      imageUrl = imageRes.secureUrl;
      // ignore: use_build_context_synchronously
      DataService.instance.insertNewDoctor(
        context,
        (value) {
          listDoctor.value = value;
          showDialog(
            context: context,
            builder: (context) => const SuccessDialog(
                question: "Insert new Doctor", title1: "Sucess"),
          );
          update(['listDoctor']);
        },
        name: nameController.text,
        address: addressController.text,
        phoneNumber: phoneController.text,
        av: imageUrl,
        departMent: DataService
            .instance.listDepartMent.value[selectDepartMent.value].id!,
        description: descriptionController.text,
        dateBorn: dateBorn.value,
        experience: experince.value,
        email: emailController.text,
        password: passController.text,
      );
    }
  }

  // Doctor detail  screen

}
