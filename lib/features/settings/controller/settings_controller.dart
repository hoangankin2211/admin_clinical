import 'dart:io';
import 'dart:typed_data';

import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../constants/global_widgets/custom_dialog_error/error_dialog.dart';
import '../../../constants/global_widgets/custom_dialog_error/success_dialog.dart';
import '../../../models/user.dart';
import '../../../services/auth_service/auth_service.dart';

class SettingController extends GetxController {
  final _auth = AuthService.instance;
  /////////////TextEditingController
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  final TextEditingController noPatientPerdayCOntroller =
      TextEditingController();
  final TextEditingController examinationFeeController =
      TextEditingController();

  ////////////value Rx
  RxBool isLoading1 = false.obs;
  RxBool isLoading2 = false.obs;
  Rx<DateTime> dateController = DateTime.now().obs;

  User getUser() => _auth.user;
  RxBool isLoading = false.obs;

  void onInit() {
    super.onInit();
    noPatientPerdayCOntroller.text =
        DataService.instance.regulation.value.maxPatientPerDay.toString();
    examinationFeeController.text =
        DataService.instance.regulation.value.examinationFee.toString();
    displayData();
    // _user.value = _auth.user;
    // update();
  }

  void displayData() {
    firstNameController.text = getUser().name;
    lastNameController.text = getUser().name;
    emailController.text = getUser().email;
    phoneNumberController.text = getUser().phoneNumber;
    selectedRole.value = getUser().gender == "Male" ? 0 : 1;
  }

  final List<String> dropDownRoleChoice = [
    'Male',
    'FeMale',
    // 'Director',
  ];
  Rx<int?> selectedRole = Rx<int?>(0);

  final Map<String, String> dropDownCountry = {
    'Vietnam': 'icons/vietnam.png',
    'United State': 'icons/united_states.png',
    'United Kingdom': 'icons/united_kingdom.png',
    'Indian': 'icons/india.png',
  };
  Rx<String> selectedCountry = Rx<String>('Vietnam');

  ///////////////////Field edit profile
  void editProfile(BuildContext context, Uint8List? image) async {
    var timeStamp = dateController.value.millisecondsSinceEpoch;
    isLoading1.value = true;
    String imageUrl = "";
    if (image != null) {
      final cloudinary = CloudinaryPublic('ddopvilpr', 'evzte9pr');
      CloudinaryResponse imageRes = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(image, identifier: getUser().email),
      );
      imageUrl = imageRes.secureUrl;
    }
    _auth.editProfile(
        name: firstNameController.text,
        email: getUser().email,
        gender: dropDownRoleChoice[selectedRole.value!],
        phoneNumber: phoneNumberController.text,
        address: getUser().address,
        dateBorn: timeStamp,
        image: imageUrl != "" ? imageUrl : getUser().avt,
        callBack: () {
          isLoading1.value = true;
          update();
          showDialog(
            context: context,
            builder: (context) => const SuccessDialog(
              question: "Edit Profile",
              title1: "Edit Profile Success",
            ),
          );
        },
        context: context);
  }

  showDialogChagepassword(String title, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ErrorDialog(
        question: "Change password",
        title1: title,
      ),
    );
  }

  Future<void> changePassword(BuildContext context) async {
    if (newPasswordController.text.length >= 8) {
      if (newPasswordController.text == rePasswordController.text) {
        final isSuccess = await _auth.changePassword(
          password: oldPasswordController.text,
          newPassword: newPasswordController.text,
          context: context,
        );

        if (isSuccess) {
          oldPasswordController.clear();
          newPasswordController.clear();
          rePasswordController.clear();
          Get.dialog(
            const SuccessDialog(
              question: "Change password",
              title1: "Update Password Success",
            ),
          );
        }
      } else {
        showDialogChagepassword('RePassword is invalid', context);
      }
    } else {
      showDialogChagepassword('Newpass is too short', context);
    }
  }

  editRegulation() async {
    isLoading.value = true;
    bool check = await DataService.instance.editRegulation(Get.context!,
        examinationFee: int.parse(examinationFeeController.text),
        maxPatientPerDay: int.parse(noPatientPerdayCOntroller.text));
    if (check) {
      isLoading.value = false;
      Get.dialog(
          const SuccessDialog(question: "Edit Regulation", title1: "Success"));
    }
  }
}
