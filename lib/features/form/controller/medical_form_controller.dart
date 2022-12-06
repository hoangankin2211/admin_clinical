import 'package:admin_clinical/constants/utils.dart';
import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:admin_clinical/services/data_service/medicine_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../models/health_record.dart';
import '../../../models/medicine.dart';

class MedicalFormController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

//////////////////////////////////////////////////////////////////////
  final List<Medicine> medicines = [];

  final List<Map<String, dynamic>> resultIndicationRowData = [
    {
      'id': "ID",
      'name': 'Name',
      'departmentID': 'Department ID',
      'amount': 'Amount',
      'departmentCharge': 'Department Charge',
      'pricePerUnit': 'Price Per Unit',
      'amountPrice': 'Amount Money'
    },
  ];

  final List<Map<String, dynamic>> rowServiceIndicationData = [
    {
      'isSelected': false.obs,
      'id': "ID",
      'name': 'Name',
      'departmentID': 'Department ID'
    },
    {
      'isSelected': false.obs,
      'id': "123",
      'name': 'Sieu am am dao',
      'departmentID': '63456'
    },
    {
      'isSelected': false.obs,
      'id': "123",
      'name': 'Sieu am am dao',
      'departmentID': '63456'
    },
    {
      'isSelected': false.obs,
      'id': "123",
      'name': 'Sieu am am dao',
      'departmentID': '63456'
    },
    {
      'isSelected': false.obs,
      'id': "123",
      'name': 'Sieu am am dao',
      'departmentID': '63456'
    },
    {
      'isSelected': false.obs,
      'id': "123",
      'name': 'Sieu am am dao',
      'departmentID': '63456'
    },
    {
      'isSelected': false.obs,
      'id': "123",
      'name': 'Sieu am am dao',
      'departmentID': '63456'
    },
    {
      'isSelected': false.obs,
      'id': "123",
      'name': 'Sieu am am dao',
      'departmentID': '63456'
    },
    {
      'isSelected': false.obs,
      'id': "123",
      'name': 'Sieu am am dao',
      'departmentID': '63456'
    },
  ];

//////////////////////////////////////////////////////////////////////
  final List<Map<String, dynamic>> examField = [
    {
      'title': 'Clinical Examination',
      'maxLine': 4,
      'icon': Icons.checklist_rounded,
      'textController': TextEditingController(),
    },
    {
      'title': 'Symptom',
      'maxLine': 4,
      'icon': Icons.playlist_add_check_circle_rounded,
      'textController': TextEditingController(),
    },
    {
      'title': 'Diagnostic',
      'maxLine': 4,
      'icon': Icons.file_copy_rounded,
      'textController': TextEditingController(),
    },
    {
      'title': 'Conclusion and Treatment',
      'maxLine': 4,
      'icon': Icons.confirmation_number_rounded,
      'textController': TextEditingController(),
    },
  ];

  final List<Map<String, dynamic>> measureField = [
    {
      'title': 'Weight',
      'maxLine': 1,
      'icon': Icons.scale_outlined,
      'inputFormatters': [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*'))
      ],
      'textController': TextEditingController(),
    },
    {
      'title': 'Height',
      'maxLine': 1,
      'icon': Icons.height_rounded,
      'inputFormatter': [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*'))
      ],
      'textController': TextEditingController(),
    },
    {
      'title': 'Heartbeat',
      'maxLine': 1,
      'icon': Icons.monitor_heart_rounded,
      'inputFormatters': [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*'))
      ],
      'textController': TextEditingController(),
    },
    {
      'title': 'Temperature',
      'maxLine': 1,
      'icon': Icons.ac_unit_rounded,
      'inputFormatters': [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*'))
      ],
      'textController': TextEditingController(),
    },
    {
      'title': 'Blood Pressure',
      'maxLine': 1,
      'icon': Icons.bloodtype_rounded,
      'inputFormatters': [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*'))
      ],
      'textController': TextEditingController(),
    },
    {
      'title': 'Allergy',
      'maxLine': 2,
      'icon': Icons.sick_rounded,
      'textController': TextEditingController(),
    },
  ];
  //////////////////////////////////////////////////////////////////////
  void onPressedCreateButton(BuildContext context) async {
    final isValidated = formKey.currentState!.validate();
    if (isValidated) {
      formKey.currentState!.save();
      isLoading.value = true;
      final response = await createNewHealthRecord(context);
      isLoading.value = false;
      Utils.notifyHandle(
        response: response,
        successTitle: 'Success',
        successQuestion: 'Create new Health Record Success',
        errorTitle: 'ERROR',
        errorQuestion:
            'Something occurred !!! Please check your internet connection',
      );
    }
  }

  void onPressedDeleteButton(String id, BuildContext context) async {
    isLoading.value = true;
    final response = await deleteHealthRecordData(id, context);
    isLoading.value = false;
    Utils.notifyHandle(
      response: response,
      successTitle: 'Success',
      successQuestion: 'Delete Health Record Success',
      errorTitle: 'ERROR',
      errorQuestion:
          'Something occurred !!! Please check your internet connection',
    );
  }

  void onPressedUpdateButton(
      HealthRecord newHealthRecord, BuildContext context) async {
    final isValidated = formKey.currentState!.validate();
    if (isValidated) {
      formKey.currentState!.save();
      isLoading.value = true;
      final response = await editHealthRecordData(newHealthRecord, context);
      isLoading.value = false;
      Utils.notifyHandle(
        response: response,
        successTitle: 'Success',
        successQuestion: 'Updated new Health Record Success',
        errorTitle: 'ERROR',
        errorQuestion:
            'Something occurred !!! Please check your internet connection',
      );
    }
  }

//////////////////////////////////////////////////////////////////////
  Future<bool> createNewHealthRecord(BuildContext context) async {
    try {
      HealthRecord newRecord = HealthRecord(
        dateCreate: DateTime.now(),
        departmentId: 'departmentId',
        doctorId: 'doctorId',
        totalMoney: 0,
        allergy:
            (measureField[5]['textController'] as TextEditingController).text,
        bloodPressure: double.parse(
            (measureField[4]['textController'] as TextEditingController).text),
        clinicalExamination:
            (examField[0]['textController'] as TextEditingController).text,
        conclusionAndTreatment:
            (examField[3]['textController'] as TextEditingController).text,
        diagnostic:
            (examField[2]['textController'] as TextEditingController).text,
        heartBeat: double.parse(
            (measureField[2]['textController'] as TextEditingController).text),
        height: double.parse(
            (measureField[5]['textController'] as TextEditingController).text),
        id: (measureField[5]['textController'] as TextEditingController).text,
        medicines: null,
        note: (measureField[5]['textController'] as TextEditingController).text,
        services: null,
        symptom:
            (measureField[5]['textController'] as TextEditingController).text,
        temperature: double.parse(
            (measureField[5]['textController'] as TextEditingController).text),
        weight: double.parse(
            (measureField[5]['textController'] as TextEditingController).text),
      );
      Map<String, dynamic> newRecordMap = newRecord.toMap();

      final response =
          await HealthRecordService.insertHealthRecord(newRecordMap, context);
      if (response != null) {
        print(response);
        newRecord.id = response;
        HealthRecordService.listHealthRecord.addAll({response: newRecord});
        return true;
      }
    } catch (e) {
      print('createNewHealthRecord: $e');
    }
    return false;
  }

  Future<bool> editHealthRecordData(
      HealthRecord healthRecord, BuildContext context) async {
    try {
      final response =
          await HealthRecordService.editHealthRecord(healthRecord, context);
      if (response != null) {
        if (response['isSuccess'] != null &&
            response['isSuccess'] == true &&
            response['id'] != null) {
          HealthRecordService.listHealthRecord
              .update(response['id'], (value) => value = healthRecord);
          return true;
        }
      }
    } catch (e) {
      print('editHealthRecordData: ${e.toString()}');
    }
    return false;
  }

  Future<bool> deleteHealthRecordData(String id, BuildContext context) async {
    try {
      final response =
          await HealthRecordService.deleteHealthRecord(id, context);
      if (response) {
        HealthRecordService.listHealthRecord.remove(id);
        return true;
      }
      return false;
    } catch (e) {
      print('editHealthRecordData: ${e.toString()}');
    }
    return false;
  }

  //////////////////////////////////////////////////////////////////////
  void onChoiceServiceChange(bool value, int index) {
    if (value) {
      (rowServiceIndicationData.elementAt(index)['isSelected'] as RxBool)
          .value = value;
      resultIndicationRowData.add(
        {
          'id': "123",
          'name': 'Sieu am am dao',
          'departmentID': '63456',
          'amount': '2',
          'departmentCharge': 'Clinical Department',
          'pricePerUnit': '1.000.000',
          'amountPrice': '2.000.000'
        },
      );
    } else {
      (rowServiceIndicationData.elementAt(index)['isSelected'] as RxBool)
          .value = value;
      resultIndicationRowData.removeAt(0);
    }
    update(['resultService']);
  }

  final Rx<List<Medicine>> listMedicineIndicator =
      Rx<List<Medicine>>(MedicineService.instance.listMedicine);

  void onChoiceMedicineChange(bool value, String id) {
    int? index;
    for (int i = 0; i < medicines.length; i++) {
      if (medicines.elementAt(i).id.compareTo(id) == 0) {
        index = i;
        break;
      }
    }
    if (index == null) return;
    Medicine temp = medicines.elementAt(index);
    if (value) {
      // listMedicineIndicator.value.add(
      //   Medicine(
      //     type: temp.type,
      //     id: temp.id,
      //     name: temp.name,
      //     price: temp.price,
      //     provider: temp.provider,
      //     unit: temp.unit,
      //   ),
      // );
      print("added");
    } else {
      listMedicineIndicator.value
          .removeWhere((element) => element.id.compareTo(temp.id) == 0);
    }
    print(medicines.length);
    update(['ResultMedicineTableRow']);
  }
}
