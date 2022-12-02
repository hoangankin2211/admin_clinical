import 'dart:math';

import 'package:admin_clinical/features/patient/controller/patient_page_controller.dart';
import 'package:admin_clinical/models/thongtinbenhnhan.dart';
import 'package:admin_clinical/services/data_service/patient_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

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
  late var phoneCode = dropDownItem.first.obs;
  late var genderCode = dropDownItemGender.first.obs;
  final patientPageController = Get.find<PatientPageController>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController symptomController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future _handleProcessInsertData(BuildContext context) async {
    _isLoading.value = true;

    final response = await patientPageController.addPatientToDataBase(
        Patient(
          id: '',
          name: firstNameController.text,
          gender: 'gender',
          address: 'address',
          dob: 'dob',
          phoneNumber: ' phoneNumber',
          status: 'status',
          avt: 'avt',
        ),
        context);
    _isLoading.value = false;

    if (response) {
      if (response) {
        Get.dialog(
          const SuccessDialog(
              question: 'Add Patient Success',
              title1: 'Added new patient to database'),
        ).then((value) => Get.back());
      } else {
        Get.dialog(
          const ErrorDialog(
            question: 'ERROR',
            title1: 'Can\'t create new patient !!! Some error have occurred',
          ),
        ).then((value) => Get.back());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: SingleChildScrollView(
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
                  : Form(
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
                            height: 0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomTextFormField(
                                width: width * 0.4,
                                title: 'First Name',
                                hint: 'Enter your first Name',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "This Field can not be emptied";
                                  }
                                  return null;
                                },
                              ),
                              const Spacer(),
                              CustomTextFormField(
                                width: width * 0.4,
                                title: 'Last Name',
                                hint: 'Enter your last name',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "This Field can not be emptied";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                              const Spacer(),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 3,
                                fit: FlexFit.tight,
                                child: CustomTextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "This Field can not be emptied";
                                    }
                                    return null;
                                  },
                                  controller: firstNameController,
                                  width: width * 0.4,
                                  title: 'Date Of Birth',
                                  hint: 'Enter your your date of birth',
                                ),
                              ),
                              const SizedBox(width: 50),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
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
                            ],
                          ),
                          CustomTextFormField(
                            controller: symptomController,
                            width: width,
                            title: 'Symptom',
                            hint: 'Describe your symptom',
                            maxLine: 10,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This Field can not be emptied";
                              }
                              return null;
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () async {
                                    final isValidated =
                                        formKey.currentState!.validate();
                                    if (isValidated) {
                                      formKey.currentState!.save();
                                    }
                                    // await _handleProcessInsertData(context);
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
            )),
      ),
    );
  }
}
