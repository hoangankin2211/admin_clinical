import 'dart:math';
import 'dart:typed_data';

import 'package:admin_clinical/constants/utils.dart';
import 'package:admin_clinical/features/decentralization_doctor/screen/doctor_dec_overview.dart';
import 'package:admin_clinical/features/patient/controller/patient_page_controller.dart';
import 'package:admin_clinical/models/patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_decoration.dart';
import '../../../constants/global_widgets/custom_dialog_error/error_dialog.dart';
import '../../../constants/global_widgets/custom_dialog_error/success_dialog.dart';
import 'custom_text_form_field.dart';

// ignore: must_be_immutable
class EditPatientDialog extends StatelessWidget {
  EditPatientDialog(
      {super.key,
      required this.height,
      required this.width,
      required this.patient});
  final Patient patient;

  final formKey = GlobalKey<FormState>();

  final double height;
  final double width;
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
  TextEditingController dateOfBirth = TextEditingController();
  final Rx<Uint8List?> _avt = Rx(null);
  final Rx<ImageProvider> image = Rx(const AssetImage('images/user.png'));
  // final Rx<Uint8List?> newAvt = Rx(null);
  final _isLoading = false.obs;
  DateTime currentDateTime = DateTime.now();

  Future<bool> _fetchDataToField() async {
    fullNameController.text = patient.name;
    locationController.text = patient.address;
    emailController.text = patient.email ?? "";
    phoneNumberController.text = patient.phoneNumber.split(" ").elementAt(1);
    symptomController.text = patient.symptom ?? "";
    image.value = patient.avt == null || patient.avt!.isEmpty
        ? const AssetImage('images/user.png')
        : NetworkImage(patient.avt!) as ImageProvider;
    phoneCode.value = patient.phoneNumber.split(" ").elementAt(0);
    genderCode.value = patient.gender;
    statusCode.value = patient.status;
    dateOfBirth.text = patient.dob;
    return true;
  }

  Future _handleProcessEditData(BuildContext context) async {
    _isLoading.value = true;

    String? result =
        await Utils.convertAssetsToUrl(_avt.value, emailController.text);

    final response = await patientPageController.editPatientData(
      Patient(
          email: emailController.text,
          id: patient.id,
          name: fullNameController.text,
          gender: genderCode.value,
          address: locationController.text,
          dob: dateOfBirth.text,
          phoneNumber: "${phoneCode.value} ${phoneNumberController.text}",
          status: statusCode.value,
          avt: result ?? patient.avt,
          symptom: symptomController.text,
          healthRecord: patient.healthRecord),
      Get.context ?? context,
    );
    if (response) {
      await Get.dialog(
        const SuccessDialog(
            question: 'Update Patient Success',
            title1: 'Updated new patient information to database'),
      );
      Get.back();
    } else {
      Get.dialog(
        const ErrorDialog(
          question: 'ERROR',
          title1:
              'Can\'t update new patient information !!! Some error have occurred, check your internet connection',
        ),
      );
      Get.back();
    }
  }

  void _selectedImage() async {
    Uint8List avt = await pickImage(ImageSource.gallery);
    _avt.value = avt;
    image.value = MemoryImage(avt);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: FutureBuilder(
          future: _fetchDataToField(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                if (snapshot.data as bool) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 25),
                    height: height,
                    width: width,
                    constraints:
                        BoxConstraints(maxHeight: height, maxWidth: width),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Edit Patient',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
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
                                          backgroundImage: image.value,
                                          radius: Get.width * 0.1,
                                          child: ((patient.avt != null &&
                                                      patient
                                                          .avt!.isNotEmpty) ||
                                                  (_avt.value != null &&
                                                      _avt.value!.isNotEmpty))
                                              ? null
                                              : Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 5.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Icon(
                                                        Icons.camera,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        "Pick Image",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                      hint: 'Enter your first Name',
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomTextFormField(
                                          controller: emailController,
                                          width: width * 0.4,
                                          title: 'Patient Email',
                                          hint: 'email@gmail.com',
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This Field can not be emptied";
                                            }
                                            return null;
                                          },
                                        ),
                                        CustomTextFormField(
                                          controller: phoneNumberController,
                                          prefixWidget: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Obx(
                                              () => DropdownButton<String>(
                                                underline: const SizedBox(),
                                                value: phoneCode.value,
                                                items: dropDownItem
                                                    .map(
                                                        (e) => DropdownMenuItem(
                                                              value: e,
                                                              child: Text(
                                                                e,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
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
                                            if (value == null ||
                                                value.isEmpty) {
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          flex: 2,
                                          fit: FlexFit.tight,
                                          child: CustomTextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "This Field can not be emptied";
                                              }
                                              return null;
                                            },
                                            readOnly: true,
                                            onTap: () {
                                              DateTime tempDateTime =
                                                  DateTime.now();
                                              Get.dialog(
                                                Dialog(
                                                  child: ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                        maxHeight:
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.35,
                                                        maxWidth: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        ConstrainedBox(
                                                          constraints: BoxConstraints(
                                                              maxHeight: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.25),
                                                          child:
                                                              CupertinoDatePicker(
                                                            onDateTimeChanged:
                                                                (value) {
                                                              tempDateTime =
                                                                  value;
                                                            },
                                                            initialDateTime:
                                                                DateTime.now(),
                                                            maximumDate:
                                                                DateTime.now(),
                                                            minimumDate:
                                                                DateTime(
                                                                    1950, 1, 1),
                                                            mode:
                                                                CupertinoDatePickerMode
                                                                    .date,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                AppColors
                                                                    .primaryColor,
                                                            minimumSize: Size(
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.2,
                                                              50,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            Get.back(
                                                                result:
                                                                    tempDateTime);
                                                          },
                                                          child: const Text(
                                                            'Select',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ).then((value) {
                                                if (value != null) {
                                                  currentDateTime = value;
                                                  dateOfBirth.text =
                                                      DateFormat()
                                                          .add_yMMMMd()
                                                          .format(
                                                              currentDateTime);
                                                }
                                              });
                                            },
                                            controller: dateOfBirth,
                                            title: 'Date Of Birth',
                                            hint:
                                                'Enter your your date of birth',
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
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    width: 0.3,
                                                    color: Colors.blueGrey)),
                                            child: Obx(
                                              () => DropdownButton<String>(
                                                icon: const Icon(
                                                  Icons.person_rounded,
                                                  color: AppColors.primaryColor,
                                                ),
                                                underline: const SizedBox(),
                                                value: genderCode.value,
                                                items: dropDownItemGender
                                                    .map((text) =>
                                                        DropdownMenuItem(
                                                          value: text,
                                                          child: Text(
                                                            text,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                                onChanged: (value) {
                                                  genderCode.value =
                                                      value ?? '';
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
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    width: 0.3,
                                                    color: Colors.blueGrey)),
                                            child: Obx(
                                              () => DropdownButton<String>(
                                                icon: const Icon(
                                                  Icons.local_activity_outlined,
                                                  color: AppColors.primaryColor,
                                                ),
                                                underline: const SizedBox(),
                                                value: statusCode.value,
                                                items: dropDownItemStatus
                                                    .map((text) =>
                                                        DropdownMenuItem(
                                                          value: text,
                                                          child: Text(
                                                            text,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                                onChanged: (value) {
                                                  statusCode.value =
                                                      value ?? '';
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
                                              final isValidated = formKey
                                                  .currentState!
                                                  .validate();
                                              if (isValidated) {
                                                formKey.currentState!.save();
                                                await _handleProcessEditData(
                                                    context);
                                              }
                                            },
                                            style: TextButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 22),
                                              backgroundColor:
                                                  AppColors.primaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: AppDecoration
                                                    .primaryRadiusBorder,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 22),
                                              backgroundColor:
                                                  AppColors.primaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: AppDecoration
                                                    .primaryRadiusBorder,
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
                  );
                }
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
