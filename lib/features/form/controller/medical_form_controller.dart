import 'package:admin_clinical/constants/utils.dart';
import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:admin_clinical/services/data_service/medicine_service.dart';
import 'package:admin_clinical/services/data_service/service_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../models/health_record.dart';
import '../../../models/medicine.dart';
import '../../../models/service.dart';

class MedicalFormController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  var isCreatedForm = false.obs;

  void updateGetBuilder(List<String> id) {
    update(id);
  }

  Rx<HealthRecord?> currentHealthRecord = Rx(null);
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
      'inputFormatters': [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*'))
      ],
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

      if (response['isSuccess']) {
        isCreatedForm.value = true;

        currentHealthRecord.value =
            HealthRecordService.listHealthRecord[response['id'] ?? ""];
      }
      Utils.notifyHandle(
        response: response['isSuccess'],
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

  void onPressedClearButton() async {
    (measureField[5]['textController'] as TextEditingController).clear();
    (measureField[4]['textController'] as TextEditingController).clear();
    (examField[0]['textController'] as TextEditingController).clear();
    (examField[3]['textController'] as TextEditingController).clear();
    (examField[2]['textController'] as TextEditingController).clear();
    (measureField[2]['textController'] as TextEditingController).clear();
    (measureField[1]['textController'] as TextEditingController).clear();
    (measureField[5]['textController'] as TextEditingController).clear();
    (examField[1]['textController'] as TextEditingController).clear();
    (measureField[3]['textController'] as TextEditingController).clear();
    (measureField[0]['textController'] as TextEditingController).clear();
  }

//////////////////////////////////////////////////////////////////////
  Future<Map<String, dynamic>> createNewHealthRecord(
      BuildContext context) async {
    try {
      List<Map<String, dynamic>> serviceFinal = [];
      List<Map<String, dynamic>> medicineFinal = [];

      await Future(
        () {
          listMedicineIndicator.forEach((key, value) {
            Map<String, dynamic> temp = {};
            temp['medicine'] = value.id;
            temp['provider'] = 'USA';
            temp['quantity'] = 1;
            temp['amount'] = amountMedicine.value;
            medicineFinal.add(temp);
          });
          listMedicineIndicator.forEach((key, value) {
            Map<String, dynamic> temp = {};
            temp['service'] = value.id;
            temp['provider'] = 'Nero';
            temp['quantity'] = 1;
            temp['amount'] = serviceAmount.value;
            serviceFinal.add(temp);
          });
        },
      );

      HealthRecord newRecord = HealthRecord(
        dateCreate: DateTime.now(),
        departmentId: 'departmentId',
        doctorId: 'doctorId',
        totalMoney: totalMoney.value,
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
            (measureField[1]['textController'] as TextEditingController).text),
        note: (measureField[5]['textController'] as TextEditingController).text,
        symptom: (examField[1]['textController'] as TextEditingController).text,
        temperature: double.parse(
            (measureField[3]['textController'] as TextEditingController).text),
        weight: double.parse(
            (measureField[0]['textController'] as TextEditingController).text),
        medicines: medicineFinal,
        services: serviceFinal,
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

  Future<bool> editHealthRecordData(
      HealthRecord healthRecord, BuildContext context) async {
    try {
      isLoading.value = true;
      final response =
          await HealthRecordService.editHealthRecord(healthRecord, context);
      isLoading.value = false;
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
      isLoading.value = true;
      final response =
          await HealthRecordService.deleteHealthRecord(id, context);
      isLoading.value = false;
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

  /////////////////////////////////////////////////////////////////////
  void createNewService(Map<String, dynamic> map) async {
    try {
      final response = await ServiceDataService.instance.addNewService(map);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  /////////////t/////////////////////////////////////////////////////////
  var amountMedicine = 0.0.obs;
  void updateMedicineAmount(double newValue) {
    amountMedicine.value += newValue;
  }

  var totalMoney = 0.0.obs;
  void updateTotalMoney(double newValue) {
    totalMoney.value += newValue;
  }

  var serviceAmount = 0.0.obs;
  void updateServiceAmount(double newValue) {
    serviceAmount.value += newValue;
  }

  /////////////////////////////////////////////////////////////////////
  bool isSelected(String id) {
    return listMedicineIndicator.containsKey(id);
  }

  bool isSelectedService(String id) {
    return listServiceIndicator.containsKey(id);
  }

  //////////////////////////////////////////////////////////////////////\
  Map<String, Service> listServiceIndicatorFINAL = {};
  late final RxMap<String, Service> listServiceIndicator =
      RxMap<String, Service>({});

  final Map<String, Service> services = ServiceDataService.instance.service;
  void onChoiceServiceChange(bool value, String id) {
    int? index;
    for (int i = 0; i < services.length; i++) {
      if (services.entries.elementAt(i).value.id?.compareTo(id) == 0) {
        index = i;
        break;
      }
    }
    if (index == null) return;
    Service temp = services.entries.elementAt(index).value;
    if (value) {
      listServiceIndicator.addAll({id: temp});
      updateServiceAmount(temp.price ?? 0.0);
    } else {
      listServiceIndicator.remove(id);
      updateServiceAmount(-(temp.price ?? 0.0));
    }
    update(['resultService', id]);
  }

  Map<String, Medicine> listMedicineIndicatorFINAL = {};
  late final RxMap<String, Medicine> listMedicineIndicator =
      RxMap<String, Medicine>({});

  final List<Medicine> medicines = MedicineService.instance.listMedicine;

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
      listMedicineIndicator.addAll({id: temp});
      updateMedicineAmount(temp.cost);
    } else {
      listMedicineIndicator.remove(id);
      updateMedicineAmount(-temp.cost);
    }
    update(['ResultMedicineTableRow', id]);
  }
}
