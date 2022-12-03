import 'dart:typed_data';

import 'package:admin_clinical/constants/global_widgets/custom_dialog_error/error_dialog.dart';
import 'package:admin_clinical/constants/global_widgets/custom_dialog_error/success_dialog.dart';
import 'package:admin_clinical/constants/utils.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/department.dart';
import '../../../models/doctor.dart';
import '../../../services/data_service/data_service.dart';

class DoctorMainController extends GetxController {
  RxList<Department> listDepartMent = <Department>[].obs;
  RxList<Department> listDepartMentForSearch = <Department>[].obs;
  RxList<Doctor1> listDoctor = <Doctor1>[].obs;
  RxList<Doctor1> listSearchDoctor = <Doctor1>[].obs;

  @override
  void onInit() {
    super.onInit();
    listDepartMent.value = DataService.instance.listDepartMent.value;
    listDoctor.value = DataService.instance.listDoctor.value;
    listDepartMentForSearch.value = DataService.instance.listDepartMent.value;
    listDepartMentForSearch.value.add(Department(id: '00', name: 'All'));
    update(['listDoctor']);
  }

  Department getDepartMent(String id, List<Department> list) =>
      list.firstWhere((element) => element.id == id);
  RxInt selectDoctor = 0.obs;
  RxInt selectDepartMent = 0.obs;
  RxInt selectDepartMentFotSearch = 0.obs;
  RxInt experince = 0.obs;
  RxString departMent = "01".obs;
  Rx<DateTime> dateBorn = DateTime.now().obs;
  RxInt gender = 0.obs;
  // Text Editting controller
  final TextEditingController searchController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  //function

  getCountDoctorInDepart(String id) {
    int count = 0;
    listDoctor.value.forEach(
        (element) => (element.departMent == id) ? count += 1 : count += 0);
    return count;
  }

  fetchSearchDoctor(BuildContext context, String searchQuery) async {
    if (searchQuery != "") {
      listSearchDoctor.value = await DataService.instance.searchDoctor(
          context,
          searchQuery,
          listDepartMentForSearch.value[selectDepartMentFotSearch.value].id!);
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

  void initAllDataDialogEdit() {
    Doctor1 sel = listDoctor.value[selectDoctor.value];
    nameController.text = sel.name!;
    addressController.text = sel.address!;
    dateBorn.value = sel.dateBorn!;
    phoneController.text = sel.phoneNumber!;
    descriptionController.text = sel.description!;
    experince.value = sel.experience!;
  }

  void nullAllTextField() {
    nameController.clear();
    addressController.clear();
    addressController.clear();
    dateBorn.value = DateTime.now();
    phoneController.clear();
    descriptionController.clear();
    experince.value = 0;
  }

  editDoctor(BuildContext context, Uint8List? image) async {
    if (nameController.text == "" ||
        addressController.text == "" ||
        phoneController.text == "") {
      await showDialog(
        context: context,
        builder: (context) => const ErrorDialog(
            question: "Edit new Doctor", title1: "Field is null"),
      );
    } else {
      String imageUrl = "";
      if (image != null) {
        imageUrl = await convertUti8ListToUrl(
            image, listDepartMent.value[selectDepartMent.value].id!);
      }
      // ignore: use_build_context_synchronously
      DataService.instance.editDoctor(
        context,
        (value) {
          listDoctor.value = value;
          showDialog(
            context: context,
            builder: (context) =>
                const SuccessDialog(question: "Edit Doctor", title1: "Success"),
          );
          update(['listDoctor']);
        },
        id: listDoctor.value[selectDoctor.value].iDBS!,
        name: nameController.text,
        address: addressController.text,
        phoneNumber: phoneController.text,
        av: imageUrl != ""
            ? imageUrl
            : listDoctor.value[selectDoctor.value].avt!,
        departMent: DataService
            .instance.listDepartMent.value[selectDepartMent.value].id!,
        description: descriptionController.text,
        dateBorn: dateBorn.value,
        experience: experince.value,
      );
    }
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
      String imageUrl = await convertUti8ListToUrl(image, emailController.text);
      // ignore: use_build_context_synchronously
      DataService.instance.insertNewDoctor(
        context,
        (value) {
          listDoctor.value = value;
          showDialog(
            context: context,
            builder: (context) => const SuccessDialog(
                question: "Insert new Doctor", title1: "Success"),
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
