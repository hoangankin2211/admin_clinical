import 'dart:math';
import 'dart:typed_data';

import 'package:admin_clinical/constants/utils.dart';
import 'package:admin_clinical/features/patient/controller/patient_page_controller.dart';
import 'package:admin_clinical/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_decoration.dart';
import '../../../constants/global_widgets/custom_dialog_error/error_dialog.dart';
import '../../../constants/global_widgets/custom_dialog_error/success_dialog.dart';
import 'custom_text_form_field.dart';

// ignore: must_be_immutable
class AddPatientDialog extends StatelessWidget {
  AddPatientDialog({super.key, required this.height, required this.width});

  final double height;
  final double width;
  final _isLoading = false.obs;
  List<String> dropDownItem = ['+84', '+86', '+42', '+88', '+14', '+52', '+50'];
  List<String> dropDownItemGender = ["Male", "Female", 'Other'];
  List<String> dropDownItemStatus = ["Uncompleted", "Completed", 'Out-Patient'];
  late var phoneCode = dropDownItem.first.obs;
  late var genderCode = dropDownItemGender.first.obs;
  late var statusCode = dropDownItemStatus.first.obs;
  final patientPageController = Get.find<PatientPageController>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController symptomController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future _handleProcessInsertData(BuildContext context) async {
    _isLoading.value = true;

    String? result =
        await Utils.convertAssetsToUrl(_avt.value, emailController.text);

    final response = await patientPageController.addPatientToDataBase(
      Patient(
        id: '',
        name: fullNameController.text,
        gender: genderCode.value,
        email: emailController.text,
        address: locationController.text,
        dob: '22-11-2002',
        phoneNumber: "${phoneCode.value} ${phoneNumberController.text}",
        status: statusCode.value,
        avt: result,
        symptom: symptomController.text,
      ),
      Get.context ?? context,
    );
    if (response) {
      await Get.dialog(
        const SuccessDialog(
            question: 'Add Patient Success',
            title1: 'Added new patient to database'),
      );
      Get.back();
    } else {
      Get.dialog(
        const ErrorDialog(
          question: 'ERROR',
          title1: 'Can\'t create new patient !!! Some error have occurred',
        ),
      );
      Get.back();
    }
  }

  late final Rx<Uint8List?> _avt = Rx(null);

  void _selectedImage() async {
    Uint8List avt = await pickImage(ImageSource.gallery);
    _avt.value = avt;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        height: height,
        width: width,
        constraints: BoxConstraints(maxHeight: height, maxWidth: width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Obx(
          () => _isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Add New Patient',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            InkWell(
                              onTap: Get.back,
                              child: Icon(
                                Icons.clear_outlined,
                                color: Colors.grey[350],
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.grey[350]!,
                          thickness: 0.6,
                          height: 15,
                        ),
                        const SizedBox(height: 15),
                        InkWell(
                          onTap: () => _selectedImage(),
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[100],
                              backgroundImage: (_avt.value != null)
                                  ? MemoryImage(_avt.value!) as ImageProvider
                                  : const AssetImage('images/user.png'),
                              radius: Get.width * 0.1,
                              child: (_avt.value != null)
                                  ? null
                                  : Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Colors.black.withOpacity(0.2),
                                        image: (_avt.value != null)
                                            ? DecorationImage(
                                                image: MemoryImage(_avt.value!),
                                              )
                                            : null,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.camera,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Pick Image",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Utils.spaceSizeBoxAddPatientDialog,
                        Utils.spaceSizeBoxAddPatientDialog,
                        CustomTextFormField(
                          controller: fullNameController,
                          title: 'First Name',
                          hint: 'Enter your full Name',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This Field can not be emptied";
                            }
                            return null;
                          },
                        ),
                        Utils.spaceSizeBoxAddPatientDialog,
                        CustomTextFormField(
                          controller: locationController,
                          width: width,
                          title: 'Location',
                          hint: 'Enter your current Address',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This Field can not be emptied";
                            }
                            return null;
                          },
                        ),
                        Utils.spaceSizeBoxAddPatientDialog,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextFormField(
                              controller: emailController,
                              width: width * 0.4,
                              title: 'Patient Email',
                              hint: 'email@gmail.com',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This Field can not be emptied";
                                }
                                return null;
                              },
                            ),
                            CustomTextFormField(
                              controller: phoneNumberController,
                              prefixWidget: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Obx(
                                  () => DropdownButton<String>(
                                    underline: const SizedBox(),
                                    value: phoneCode.value,
                                    items: dropDownItem
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(
                                                e,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      phoneCode.value = value ?? '';
                                    },
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This Field can not be emptied";
                                }
                                return null;
                              },
                              width: width * 0.4,
                              title: 'Phone Number',
                              hint: '123456',
                            ),
                          ],
                        ),
                        Utils.spaceSizeBoxAddPatientDialog,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: CustomTextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "This Field can not be emptied";
                                  }
                                  return null;
                                },
                                controller: null,
                                title: 'Date Of Birth',
                                hint: 'Enter your your date of birth',
                              ),
                            ),
                            const SizedBox(width: 25),
                            Flexible(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 0.3, color: Colors.blueGrey)),
                                child: Obx(
                                  () => DropdownButton<String>(
                                    icon: const Icon(
                                      Icons.person_rounded,
                                      color: AppColors.primaryColor,
                                    ),
                                    underline: const SizedBox(),
                                    value: genderCode.value,
                                    items: dropDownItemGender
                                        .map((text) => DropdownMenuItem(
                                              value: text,
                                              child: Text(
                                                text,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      genderCode.value = value ?? '';
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 0.3, color: Colors.blueGrey)),
                                child: Obx(
                                  () => DropdownButton<String>(
                                    icon: const Icon(
                                      Icons.local_activity_outlined,
                                      color: AppColors.primaryColor,
                                    ),
                                    underline: const SizedBox(),
                                    value: statusCode.value,
                                    items: dropDownItemStatus
                                        .map((text) => DropdownMenuItem(
                                              value: text,
                                              child: Text(
                                                text,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      statusCode.value = value ?? '';
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Utils.spaceSizeBoxAddPatientDialog,
                        CustomTextFormField(
                          controller: symptomController,
                          width: width,
                          title: 'Symptom',
                          hint: 'Describe your symptom',
                          maxLine: 10,
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return "This Field can not be emptied";
                          //   }
                          //   return null;
                          // },
                        ),
                        Utils.spaceSizeBoxAddPatientDialog,
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () async {
                                  final isValidated =
                                      formKey.currentState!.validate();
                                  if (isValidated) {
                                    formKey.currentState!.save();
                                    await _handleProcessInsertData(context);
                                  }
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 22),
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        AppDecoration.primaryRadiusBorder,
                                  ),
                                ),
                                child: const Text(
                                  'Save',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: TextButton(
                                onPressed: Get.back,
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 22),
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        AppDecoration.primaryRadiusBorder,
                                  ),
                                ),
                                child: const Text(
                                  'Clear',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
