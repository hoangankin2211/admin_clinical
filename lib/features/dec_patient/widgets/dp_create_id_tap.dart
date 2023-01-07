import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/global_widgets/custom_dialog_error/error_dialog.dart';
import '../../../constants/global_widgets/custom_dialog_error/success_dialog.dart';
import '../../../constants/utils.dart';
import '../../../models/patient.dart';
import '../../../services/data_service/data_service.dart';
import '../../../services/data_service/notification_service.dart';
import '../../auth/widgets/custom_button.dart';
import '../../patient/widgets/custom_text_form_field.dart';
import '../controller/dp_patinet_contnrolller.dart';

class DpCreateIdTab extends StatefulWidget {
  final double height;
  DpCreateIdTab({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  State<DpCreateIdTab> createState() => _DpCreateIdTabState();
}

class _DpCreateIdTabState extends State<DpCreateIdTab> {
  final controller = Get.find<DpPatinetController>();
  Uint8List? _image;
  Rx<DateTime> date = DateTime.now().obs;
  void selectedImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
      //convertoBytes();
    });
  }

  List<String> dropDownItem = ['+84', '+86', '+42', '+88', '+14', '+52', '+50'];
  List<String> dropDownItemGender = ["Male", "Female", 'Other'];
  List<String> dropDownItemStatus = ["Uncompleted", "Completed", 'Out-Patient'];
  List<String> dropDownItemDepartment = [
    for (var element in DataService.instance.listDepartMent) element.name ?? ""
  ];
  late final phoneCode = dropDownItem.first.obs;
  late final genderCode = dropDownItemGender.first.obs;
  late final statusCode = dropDownItemStatus.first.obs;
  late final departmentCode = dropDownItemDepartment.first.obs;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController symptomController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  DateTime currentDateTime = DateTime.now();

  final RxBool _isLoading = false.obs;

  void _handleProcessInsertData(BuildContext context) async {
    if (fullNameController.text == "" ||
        emailController.text == "" ||
        locationController.text == "" ||
        phoneNumberController.text == "") {
      await Get.dialog(
          const ErrorDialog(question: "Create ID", title1: "Field is null"));
    } else {
      _isLoading.value = true;

      String? result =
          await Utils.convertAssetsToUrl(_image, emailController.text);

      final response = await controller.addPatientToDataBaseReturnId(
        Patient(
          id: '',
          name: fullNameController.text,
          gender: genderCode.value,
          email: emailController.text,
          address: locationController.text,
          dob: dobController.text,
          phoneNumber: "${phoneCode.value} ${phoneNumberController.text}",
          status: statusCode.value,
          avt: result,
          symptom: symptomController.text,
          healthRecord: [],
        ),
        Get.context ?? context,
      );
      if (response['check']) {
        _isLoading.value = false;
        await Get.dialog(
          Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: Get.width / 4,
              height: Get.height / 3,
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/checked.png',
                    height: 80.0,
                    width: 80.0,
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Create ID is success',
                    style: TextStyle(
                      color: AppColors.headline1TextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        const Text(
                          'Your ID: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: AppColors.primaryColor),
                        ),
                        Expanded(
                          child: TextField(
                            controller: TextEditingController(
                              text: response['id'],
                            ),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: AppColors.headline1TextColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // RichText(
                  //     text: TextSpan(
                  //         style: const TextStyle(
                  //             fontWeight: FontWeight.bold, fontSize: 20.0),
                  //         children: [
                  //       const TextSpan(
                  //           text: 'Your ID:',
                  //           style: TextStyle(color: AppColors.primaryColor)),
                  //       TextSpan(
                  //           text: response['id'],
                  //           style: const TextStyle(
                  //               color: AppColors.headline1TextColor))
                  //     ])),
                ],
              ),
            ),
          ),
        );
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
    _isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: widget.height * 0.85,
          child: Row(
            children: [
              Column(
                children: [
                  _image != null
                      ? Container(
                          height: 200,
                          width: 200,
                          margin: const EdgeInsets.only(bottom: 20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, blurRadius: 7.0)
                            ],
                            image: DecorationImage(
                              image: MemoryImage(_image!),
                            ),
                          ),
                        )
                      : Container(
                          height: 200,
                          width: 200,
                          margin: const EdgeInsets.only(bottom: 20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, blurRadius: 7.0)
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/images/doctor1.png'),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 40.0,
                    width: 200.0,
                    child: CustomButton(
                      title: "Select Avt",
                      onPressed: () => selectedImage(),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  children: [
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
                      width: double.infinity,
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
                        Flexible(
                          flex: 2,
                          child: CustomTextFormField(
                            controller: emailController,
                            // width: width * 0.4,
                            title: 'Patient Email',
                            hint: 'email@gmail.com',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This Field can not be emptied";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
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
                        Expanded(
                          flex: 1,
                          child: CustomTextFormField(
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
                            title: 'Phone Number',
                            hint: '123456',
                          ),
                        ),
                      ],
                    ),
                    Utils.spaceSizeBoxAddPatientDialog,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This Field can not be emptied";
                              }
                              return null;
                            },
                            controller: dobController,
                            onTap: () {
                              DateTime tempDateTime = DateTime.now();
                              Get.dialog(
                                Dialog(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxHeight:
                                            MediaQuery.of(context).size.height *
                                                0.35,
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.3),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxHeight: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.25),
                                          child: CupertinoDatePicker(
                                            onDateTimeChanged: (value) {
                                              tempDateTime = value;
                                            },
                                            initialDateTime: DateTime.now(),
                                            maximumDate: DateTime.now(),
                                            minimumDate: DateTime(1950, 1, 1),
                                            mode: CupertinoDatePickerMode.date,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor:
                                                AppColors.primaryColor,
                                            minimumSize: Size(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              50,
                                            ),
                                          ),
                                          onPressed: () {
                                            Get.back(result: tempDateTime);
                                          },
                                          child: const Text(
                                            'Select',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ).then((value) {
                                if (value != null) {
                                  currentDateTime = value;
                                  dobController.text = DateFormat()
                                      .add_yMMMMd()
                                      .format(currentDateTime);
                                }
                              });
                            },
                            title: 'Date Of Birth',
                            hint: 'Enter your your date of birth',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
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
                      width: double.infinity,
                      title: 'Symptom',
                      hint: 'Describe your symptom',
                      maxLine: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        const Divider(thickness: 1),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 40.0,
              child: CustomButton(
                title: 'Cancel All',
                onPressed: () {},
                color: Colors.red,
              ),
            ),
            const SizedBox(width: 10.0),
            Obx(
              () => SizedBox(
                  height: 40.0,
                  child: CustomButton(
                      check: _isLoading.value,
                      title: 'Create',
                      onPressed: () => _handleProcessInsertData(context))),
            ),
          ],
        ),
      ],
    );
  }
}
