import 'dart:convert';

import 'package:admin_clinical/constants/utils.dart';
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
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
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
      final response = await createNewHealthRecord(patientId, context);
      isLoading.value = false;

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
            currentHealthRecord.value =
                HealthRecordService.listHealthRecord[response['id'] ?? ""];
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

  Future<void> onPressedDeleteButton(String id, BuildContext context,
      String patientId, Function() backButton) async {
    isLoading.value = true;
    bool result = false;
    final response = await deleteHealthRecordData(id, context);
    if (response) {
      try {
        final deletePatientResponse =
            await deleteHealthRecordPatient(patientId, id);
        if (deletePatientResponse) {
          backButton();
          PatientService.listPatients.update(patientId, (value) {
            HealthRecordService.listHealthRecord.remove(id);
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

    await Utils.notifyHandle(
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
        Uri.parse('${ApiLink.uri}/api/deletePatientRecord/'),
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
        result = true;
      }
    } catch (e) {
      print('updatePatientResponse: $e');
    }
    return result;
  }

  void onPressedUpdateButton(
    BuildContext context,
    String patientId,
  ) async {
    final isValidated = formKey.currentState!.validate();

    if (isValidated) {
      print(listServiceIndicatorFINAL.length);
      print(
          'listMedicineIndicatorFINAL.length${listMedicineIndicatorFINAL.length}');
      List<Map<String, dynamic>> serviceFinal = [];
      List<Map<String, dynamic>> medicineFinal = [];

      for (var element in listServiceIndicatorFINAL) {
        Map<String, dynamic> serviceFinalTemp = {};
        serviceFinalTemp.addAll({'service': element});
        serviceFinalTemp.addAll({'provider': 'USA'});
        serviceFinalTemp.addAll({'quantity': 1});
        serviceFinalTemp.addAll({'amount': 10.0});
        serviceFinal.add(serviceFinalTemp);
      }
      for (var element in listMedicineIndicatorFINAL) {
        Map<String, dynamic> medicineFinalTemp = {};
        medicineFinalTemp.addAll({'medicine': element});
        medicineFinalTemp.addAll({'provider': 'USA'});
        medicineFinalTemp.addAll({'quantity': 1});
        medicineFinalTemp.addAll({'amount': 10.0});
        medicineFinal.add(medicineFinalTemp);
      }

      Map<String, dynamic> newHealthRecord = {
        'id': currentHealthRecord.value!.id,
        'patientId': patientId,
        'dateCreate': currentHealthRecord.value!.dateCreate.toIso8601String(),
        'departmentId': 'departmentId',
        'doctorId': AuthService.instance.user.id,
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
      final response = await editHealthRecordData(newHealthRecord);
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
  }

//////////////////////////////////////////////////////////////////////
  Future<Map<String, dynamic>> createNewHealthRecord(
      String patientId, BuildContext context) async {
    try {
      List<Map<String, dynamic>> serviceFinal = [];
      List<Map<String, dynamic>> medicineFinal = [];

      await Future(
        () {
          for (var element in listServiceIndicatorFINAL) {
            Map<String, dynamic> serviceFinalTemp = {};

            serviceFinalTemp.addAll({'service': element});
            serviceFinalTemp.addAll({'provider': 'USA'});
            serviceFinalTemp.addAll({'quantity': 1});
            serviceFinalTemp.addAll({'amount': 10.0});

            serviceFinal.add(serviceFinalTemp);
          }
          for (var element in listMedicineIndicatorFINAL) {
            Map<String, dynamic> medicineFinalTemp = {};
            medicineFinalTemp.addAll({'medicine': element});
            medicineFinalTemp.addAll({'provider': 'USA'});
            medicineFinalTemp.addAll({'quantity': 1});
            medicineFinalTemp.addAll({'amount': 10.0});
            medicineFinal.add(medicineFinalTemp);
          }
        },
      );

      HealthRecord newRecord = HealthRecord(
        dateCreate: DateTime.now(),
        departmentId: 'departmentId',
        patientId: patientId,
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

  Future<bool> editHealthRecordData(Map<String, dynamic> healthRecord) async {
    try {
      isLoading.value = true;
      final response = await HealthRecordService.editHealthRecord(healthRecord);
      isLoading.value = false;
      if (response != null) {
        if (response['isSuccess'] != null &&
            response['isSuccess'] == true &&
            response['id'] != null) {
          HealthRecordService.listHealthRecord.update(
            response['id'],
            (value) {
              value = HealthRecord.fromJson(healthRecord);
              currentHealthRecord.value = value;
              return value;
            },
          );
          for (var item in healthRecord['medicines']) {
            print(item['medicine']);
            Medicine? temp = await MedicineService.instance.passMedicine(
                Get.context!,
                id: item['medicine'],
                time: DateTime.now(),
                price: item['amount']);
            if (temp != null) {
              MedicineService.instance.listMedicine[MedicineService
                  .instance.listMedicine
                  .indexWhere((element) => element.id == item)] = temp;
            }
          }
          return true;
        }
      } else {}
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
  List<String> convertMap2List(List<Map<String, dynamic>> source, String key) {
    List<String> result = [];
    for (var element in source) {
      result.add(element[key]);
    }
    return result;
  }

  //////////////////////////////////////////////////////////////////////\
  late List<String> listServiceIndicatorFINAL;
  late RxMap<String, Service> listServiceIndicator;

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

  late List<String> listMedicineIndicatorFINAL;
  late RxMap<String, Medicine> listMedicineIndicator;
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

  void fetchIndicatorService() {
    listServiceIndicatorFINAL =
        convertMap2List(currentHealthRecord.value?.services ?? [], 'service');
    for (var service in listServiceIndicatorFINAL) {
      listServiceIndicator.addAll({
        service: ServiceDataService.instance.service.entries
            .firstWhere((element) => element.value.id == service)
            .value
      });
    }
  }

  void fetchIndicatorMedicine() {
    listMedicineIndicatorFINAL =
        convertMap2List(currentHealthRecord.value?.medicines ?? [], 'medicine');
    for (var medicine in listMedicineIndicatorFINAL) {
      listMedicineIndicator.addAll({
        medicine: MedicineService.instance.listMedicine
            .firstWhere((element) => element.id == medicine)
      });
    }
  }

  void fetchIndicatorData() {
    if (currentHealthRecord.value != null) {
      fetchIndicatorMedicine();
      fetchIndicatorService();
    }
  }

  @override
  void onInit() {
    listMedicineIndicator = RxMap<String, Medicine>({});
    listServiceIndicator = RxMap<String, Service>({});
    listMedicineIndicatorFINAL = [];
    listServiceIndicatorFINAL = [];

    super.onInit();
  }

  @override
  void onClose() {
    listMedicineIndicator.close();
    listServiceIndicator.close();
    currentHealthRecord.close();
    isLoading.value = false;
    isLoading.close();
    super.onClose();
  }
}
