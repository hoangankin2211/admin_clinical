import 'dart:convert';

import 'package:admin_clinical/constants/global_widgets/custom_dialog_error/error_dialog.dart';
import 'package:admin_clinical/constants/global_widgets/custom_dialog_error/success_dialog.dart';
import 'package:admin_clinical/constants/utils.dart';
import 'package:admin_clinical/features/patient/controller/patient_page_controller.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../../constants/api_link.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_decoration.dart';
import '../../../models/health_record.dart';
import '../../../models/patient.dart';
import '../../../services/auth_service/auth_service.dart';
import '../../../services/data_service/health_record_service.dart';
import '../../../services/data_service/patient_service.dart';
import 'custom_text_form_field.dart';

// ignore: must_be_immutable
class CreateHealthRecordDialog extends StatelessWidget {
  CreateHealthRecordDialog({
    super.key,
    required this.height,
    required this.width,
    required this.patient,
  });

  final double height;
  final double width;
  final Patient patient;

  final _isLoading = false.obs;
  List<String> dropDownItemStatus = [
    "Waiting Examination",
    'Waiting Payment',
    'Out-Patient',
  ];
  List<String> dropDownItemDepartment = [
    for (var element in DataService.instance.listDepartMent) element.name ?? ""
  ];

  late final statusCode = dropDownItemStatus.first.obs;
  late final departmentCode = dropDownItemDepartment.first.obs;
  final patientPageController = Get.find<PatientPageController>();
  TextEditingController symptomController = TextEditingController();
  Rx<DateTime> currentDateTime = DateTime.now().obs;
  final formKey = GlobalKey<FormState>();

  Future<bool> _updatePatientRecord(
      String patientId, String newHealthRecord) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiLink.uri}/api/addPatientRecord/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          '_id': patientId,
          'healthRecord': newHealthRecord,
        }),
      );

      final extractedData = jsonDecode(response.body);

      if (extractedData['isSuccess'] != null && extractedData['isSuccess']) {
        return true;
      }
    } catch (e) {
      print('_updatePatientRecord: ${e.toString()}');
    }
    return false;
  }

  


  Future<Map<String, dynamic>> createNewHealthRecord(
      String patientId, BuildContext context) async {
    try {

      HealthRecord newRecord = HealthRecord(
        dateCreate: DateTime.now(),
        departmentId:
            DataService.instance.getIdDepartment(departmentCode.value),
        patientId: patientId,
        status: statusCode.value,
        doctorId: AuthService.instance.user.id,
        totalMoney: 0,
        services: [],
        medicines: [],
      );
      Map<String, dynamic> newRecordMap = newRecord.toMap();

      final response = await HealthRecordService.insertHealthRecord(
        newRecordMap,
        Get.context ?? context,
      );
      if (response != null) {
        print(response);
        newRecord.id = response;
        HealthRecordService.listHealthRecord.addAll({response: newRecord});
        return {"isSuccess": true, 'id': response};
      }
    } catch (e) {
      print('createNewHealthRecord: $e');
    }
    return {"isSuccess": false};
  }

  void onPressedCreateButton(BuildContext context, String patientId) async {
    final isValidated = formKey.currentState!.validate();
    if (isValidated) {
      bool check = false;
      // HealthRecordService.listHealthRecord.forEach((key, value) {});
      for (var item in HealthRecordService.listHealthRecord.values) {
        if (item.patientId == patientId &&
            item.status == "Waiting Examination") {
          check = true;
          break;
        }
      }
      if (!check) {
        formKey.currentState!.save();
        _isLoading.value = true;
        final response = await createNewHealthRecord(patientId, context);
        _isLoading.value = false;

        bool result = false;

        if (response['isSuccess']) {
          try {
            final updatePatientResponse = await _updatePatientRecord(
              patientId,
              response['id'],
            );
            if (updatePatientResponse) {
              PatientService.listPatients.update(patientId, (value) {
                if (value.healthRecord == null) {
                  List<String> temp = [];
                  value.healthRecord = temp;
                }
                value.healthRecord?.add(response['id'] as String);
                return value;
              });
              result = true;
            }
          } catch (e) {
            print('updatePatientResponse----: $e');
          }
        }
        Utils.notifyHandle(
          response: result,
          successTitle: 'Success',
          successQuestion: 'Create new Health Record Success',
          errorTitle: 'ERROR',
          errorQuestion:
              'Something occurred !!! Please check your internet connection',
        );
      } else {
        Get.dialog(const ErrorDialog(
            question: "Create Health Record", title1: "Wating  Examination"));
      }
    }
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
                              'Create New Health Record',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            InkWell(
                              onTap: Get.back,
                              child: const Icon(
                                Icons.clear_outlined,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.grey[350]!,
                          thickness: 0.6,
                          height: 15,
                        ),
                        Utils.spaceSizeBoxAddPatientDialog,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey[100],
                              backgroundImage: (patient.avt != null &&
                                      patient.avt!.isNotEmpty)
                                  ? NetworkImage(patient.avt!) as ImageProvider
                                  : const AssetImage('images/user.png'),
                              radius: Get.width * 0.05,
                            ),
                            const SizedBox(width: 25),
                            Expanded(
                              child: Column(
                                children: [
                                  Obx(
                                    () => CustomTextFormField(
                                      controller: TextEditingController(
                                        text: DateFormat()
                                            .add_yMMMMd()
                                            .format(currentDateTime.value),
                                      ),
                                      readOnly: true,
                                      title: 'Date Create',
                                      hint: 'Choose Date',
                                      onTap: () async {
                                        DateTime tempDateTime = DateTime.now();
                                        await Get.dialog(
                                          Dialog(
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                  maxHeight:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.35,
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.3),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                        maxHeight:
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.25),
                                                    child: CupertinoDatePicker(
                                                      onDateTimeChanged:
                                                          (value) {
                                                        tempDateTime = value;
                                                      },
                                                      initialDateTime:
                                                          DateTime.now(),
                                                      maximumDate:
                                                          DateTime.now(),
                                                      minimumDate:
                                                          DateTime(1950, 1, 1),
                                                      mode:
                                                          CupertinoDatePickerMode
                                                              .date,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                      backgroundColor: AppColors
                                                          .primaryColor,
                                                      minimumSize: Size(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                        50,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Get.back(
                                                          result: tempDateTime);
                                                    },
                                                    child: const Text(
                                                      'Select',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ).then((value) {
                                          if (value != null) {
                                            currentDateTime.value = value;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Utils.spaceSizeBoxAddPatientDialog,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
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
                                                Icons.text_snippet,
                                                color: AppColors.primaryColor,
                                              ),
                                              underline: const SizedBox(),
                                              value: departmentCode.value,
                                              items: dropDownItemDepartment
                                                  .map((text) =>
                                                      DropdownMenuItem(
                                                        value: text,
                                                        child: Text(
                                                          text,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),
                                              onChanged: (value) {
                                                departmentCode.value =
                                                    value ?? '';
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
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
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
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
                                ],
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
                        ),
                        Utils.spaceSizeBoxAddPatientDialog,
                        TextButton(
                          onPressed: () async {
                            final isValidated =
                                formKey.currentState!.validate();
                            if (isValidated) {
                              formKey.currentState!.save();
                              onPressedCreateButton(context, patient.id);
                            }
                          },
                          style: TextButton.styleFrom(
                            fixedSize: const Size(double.infinity, 50),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 22),
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: AppDecoration.primaryRadiusBorder,
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
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
