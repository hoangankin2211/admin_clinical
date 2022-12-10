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
  Rx<HealthRecord?> currentHealthRecord = Rx(null);

  final clinicalExamination = TextEditingController();
  final symptom = TextEditingController();
  final diagnostic = TextEditingController();
  final conclusionAndTreatment = TextEditingController();
  final weight = TextEditingController();
  final heartBeat = TextEditingController();
  final height = TextEditingController();
  final temperature = TextEditingController();
  final bloodPressure = TextEditingController();
  final allergy = TextEditingController();
  final note = TextEditingController();

  @override
  void onInit() {
    currentHealthRecord.listen((record) {
      if (record != null) {}
    });
    super.onInit();
  }

  void updateGetBuilder(List<String> id) {
    update(id);
  }

//////////////////////////////////////////////////////////////////////

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
        'allergy': allergy.text,
        'bloodPressure': double.parse(bloodPressure.text),
        'clinicalExamination': clinicalExamination.text,
        'conclusionAndTreatment': conclusionAndTreatment.text,
        'diagnostic': diagnostic.text,
        'heartBeat': double.parse(heartBeat.text),
        'height': double.parse(height.text),
        'note': note.text,
        'symptom': symptom.text,
        'temperature': double.parse(temperature.text),
        'weight': double.parse(weight.text),
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
    note.clear();
    clinicalExamination.clear();
    symptom.clear();
    diagnostic.clear();
    conclusionAndTreatment.clear();
    weight.clear();
    height.clear();
    heartBeat.clear();
    temperature.clear();
    bloodPressure.clear();
    allergy.clear();
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
        doctorId: 'doctorId',
        totalMoney: totalMoney.value,
        allergy: allergy.text,
        bloodPressure: double.parse(bloodPressure.text),
        clinicalExamination: clinicalExamination.text,
        conclusionAndTreatment: conclusionAndTreatment.text,
        diagnostic: diagnostic.text,
        heartBeat: double.parse(heartBeat.text),
        height: double.parse(height.text),
        note: note.text,
        symptom: symptom.text,
        temperature: double.parse(temperature.text),
        weight: double.parse(weight.text),
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
  List<String> listServiceIndicatorFINAL = [];
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

  List<String> listMedicineIndicatorFINAL = [];
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
