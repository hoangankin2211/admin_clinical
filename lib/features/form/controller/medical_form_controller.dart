import 'dart:convert';

import 'package:admin_clinical/constants/utils.dart';
import 'package:admin_clinical/features/auth/controller/auth_controller.dart';
import 'package:admin_clinical/models/patient.dart';
import 'package:admin_clinical/services/auth_service/auth_service.dart';
import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:admin_clinical/services/data_service/medicine_service.dart';
import 'package:admin_clinical/services/data_service/patient_service.dart';
import 'package:admin_clinical/services/data_service/service_data_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../constants/api_link.dart';
import '../../../models/health_record.dart';
import '../../../models/medicine.dart';
import '../../../models/service.dart';

class MedicalFormController extends GetxController {
  MedicalFormController({this.record});
  HealthRecord? record;
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  var isCreatedForm = false.obs;
  Rx<HealthRecord?> currentHealthRecord = Rx(null);

  late final Map<String, TextEditingController> textController = {
    'clinicalExamination': TextEditingController(
        text: currentHealthRecord.value?.clinicalExamination),
    'symptom': TextEditingController(text: currentHealthRecord.value?.symptom),
    'diagnostic':
        TextEditingController(text: currentHealthRecord.value?.diagnostic),
    'conclusionAndTreatment': TextEditingController(
        text: currentHealthRecord.value?.conclusionAndTreatment),
    'weight': TextEditingController(
        text: currentHealthRecord.value?.weight.toString()),
    'heartBeat': TextEditingController(
        text: currentHealthRecord.value?.heartBeat.toString()),
    'height': TextEditingController(
        text: currentHealthRecord.value?.height.toString()),
    'temperature': TextEditingController(
        text: currentHealthRecord.value?.temperature.toString()),
    'bloodPressure': TextEditingController(
        text: currentHealthRecord.value?.bloodPressure.toString()),
    'allergy': TextEditingController(text: currentHealthRecord.value?.allergy),
    'note': TextEditingController(text: currentHealthRecord.value?.note),
  };

  void updateGetBuilder(List<String> id) {
    update(id);
  }

  ////////////////////////////////////////////////////////////////////////////////

  //////////////////////////////////////////////////////////////////////
  void onPressedCreateButton(BuildContext context, String patientId) async {
    final isValidated = formKey.currentState!.validate();
    if (isValidated) {
      formKey.currentState!.save();
      isLoading.value = true;
      final response = await createNewHealthRecord(context);
      isLoading.value = false;

      bool result = false;

      if (response['isSuccess']) {
        try {
          final updatePatientResponse = await _updatePatientRecord(
            patientId,
            response['id'],
          );
          if (updatePatientResponse) {
            isCreatedForm.value = true;
            PatientService.listPatients.update(patientId, (value) {
              value.healthRecord?.add(response['id'] as String);
              return value;
            });
            currentHealthRecord.value =
                HealthRecordService.listHealthRecord[response['id'] ?? ""];
            result = true;
          }
        } catch (e) {
          print('updatePatientResponse: $e');
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
    }
  }

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

  void onPressedDeleteButton(
      String id, BuildContext context, String patientId) async {
    isLoading.value = true;
    bool result = false;
    final response = await deleteHealthRecordData(id, context);
    if (response) {
      try {
        final deletePatientResponse =
            await deleteHealthRecordPatient(patientId, id);
        if (deletePatientResponse) {
          isCreatedForm.value = true;
          PatientService.listPatients.update(patientId, (value) {
            value.healthRecord ??= [] as List<String>;
            value.healthRecord?.removeWhere((element) => element == id);
            return value;
          });
          result = false;
        }
      } catch (e) {
        print('updatePatientResponse: $e');
        result = false;
      }
    }
    isLoading.value = false;

    Utils.notifyHandle(
      response: result,
      successTitle: 'Success',
      successQuestion: 'Delete Health Record Success',
      errorTitle: 'ERROR',
      errorQuestion:
          'Something occurred !!! Please check your internet connection',
    );
  }

  Future<bool> deleteHealthRecordPatient(
      String patientId, String healthRecordId) async {
    bool result = false;
    try {
      final response = await http.post(
        Uri.parse('${ApiLink.uri}/api/editPatientRecord/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          '_id': patientId,
          'idHealthRecord': healthRecordId,
        }),
      );
      final extractedData = jsonDecode(response.body);
      if (extractedData['isSuccess'] != null && extractedData['isSuccess']) {
        PatientService.listPatients.update(patientId, (value) {
          value.healthRecord ??= [] as List<String>;
          value.healthRecord
              ?.removeWhere((element) => element == healthRecordId);
          return value;
        });
        result = true;
      }
    } catch (e) {
      print('updatePatientResponse: $e');
    }
    return result;
  }

  void onPressedUpdateButton(BuildContext context) async {
    final isValidated = formKey.currentState!.validate();

    if (isValidated) {
      List<Map<String, dynamic>> serviceFinal = [];
      List<Map<String, dynamic>> medicineFinal = [];

      await Future(
        () {
          for (var element in listServiceIndicatorFINAL) {
            serviceFinal.add({element: services[element]});
          }
          for (var element in listMedicineIndicatorFINAL) {
            medicineFinal.add({
              element:
                  medicines.firstWhere((medicine) => medicine.id == element)
            });
          }
        },
      );

      Map<String, dynamic> newHealthRecord = {
        'id': currentHealthRecord.value!.id,
        'dateCreate': currentHealthRecord.value!.dateCreate.toIso8601String(),
        'departmentId': 'departmentId',
        'doctorId': 'doctorId',
        'totalMoney': totalMoney.value,
        'allergy': (textController['allergy'] as TextEditingController).text,
        'bloodPressure': double.parse(
            (textController['bloodPressure'] as TextEditingController).text),
        'clinicalExamination':
            (textController['clinicalExamination'] as TextEditingController)
                .text,
        'conclusionAndTreatment':
            (textController['conclusionAndTreatment'] as TextEditingController)
                .text,
        'diagnostic':
            (textController['diagnostic'] as TextEditingController).text,
        'heartBeat': double.parse(
            (textController['heartBeat'] as TextEditingController).text),
        'height': double.parse(
            (textController['height'] as TextEditingController).text),
        'note': (textController['note'] as TextEditingController).text,
        'symptom': (textController['symptom'] as TextEditingController).text,
        'temperature': double.parse(
            (textController['temperature'] as TextEditingController).text),
        'weight': double.parse(
            (textController['weight'] as TextEditingController).text),
        'medicines': medicineFinal,
        'services': serviceFinal,
      };
      formKey.currentState!.save();
      isLoading.value = true;
      final response =
          await editHealthRecordData(newHealthRecord, Get.context ?? context);
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
    textController.forEach((key, value) => value.clear());
    listMedicineIndicatorFINAL.clear();
    listServiceIndicatorFINAL.clear();
    listMedicineIndicator.clear();
    listServiceIndicator.clear();
  }

//////////////////////////////////////////////////////////////////////
  Future<Map<String, dynamic>> createNewHealthRecord(
      BuildContext context) async {
    try {
      List<Map<String, dynamic>> serviceFinal = [];
      List<Map<String, dynamic>> medicineFinal = [];

      await Future(
        () {
          for (var element in listServiceIndicatorFINAL) {
            serviceFinal.add({element: services[element]});
          }
          for (var element in listMedicineIndicatorFINAL) {
            medicineFinal.add({
              element:
                  medicines.firstWhere((medicine) => medicine.id == element)
            });
          }
        },
      );

      HealthRecord newRecord = HealthRecord(
        dateCreate: DateTime.now(),
        departmentId: 'departmentId',
        doctorId: AuthService.instance.user.id,
        totalMoney: totalMoney.value,
        allergy: (textController['allergy'] as TextEditingController).text,
        bloodPressure: double.parse(
            (textController['bloodPressure'] as TextEditingController).text),
        clinicalExamination:
            (textController['clinicalExamination'] as TextEditingController)
                .text,
        conclusionAndTreatment:
            (textController['conclusionAndTreatment'] as TextEditingController)
                .text,
        diagnostic:
            (textController['diagnostic'] as TextEditingController).text,
        heartBeat: double.parse(
            (textController['heartBeat'] as TextEditingController).text),
        height: double.parse(
            (textController['height'] as TextEditingController).text),
        note: (textController['note'] as TextEditingController).text,
        symptom: (textController['symptom'] as TextEditingController).text,
        temperature: double.parse(
            (textController['temperature'] as TextEditingController).text),
        weight: double.parse(
            (textController['weight'] as TextEditingController).text),
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
      Map<String, dynamic> healthRecord, BuildContext context) async {
    try {
      isLoading.value = true;
      final response =
          await HealthRecordService.editHealthRecord(healthRecord, context);
      isLoading.value = false;
      if (response != null) {
        if (response['isSuccess'] != null &&
            response['isSuccess'] == true &&
            response['id'] != null) {
          HealthRecordService.listHealthRecord.update(response['id'],
              (value) => value = HealthRecord.fromJson(healthRecord));
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
  List<String> convertMap2List(List<Map<String, dynamic>> source) {
    List<String> result = [];
    for (var element in source) {}
    return result;
  }

  //////////////////////////////////////////////////////////////////////\
  late List<String> listServiceIndicatorFINAL = convertMap2List(
    currentHealthRecord.value?.services ?? [],
  );
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

  late List<String> listMedicineIndicatorFINAL = [];
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
