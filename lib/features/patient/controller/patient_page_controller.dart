import 'package:admin_clinical/models/patient.dart';
import 'package:admin_clinical/services/data_service/patient_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PatientPageController extends GetxController {
  final Rx<String?> selectedPatient = Rx(null);

  late final Rx<Map<String, Patient>> data;

  var isLoading = false.obs;

  @override
  void onInit() {
    data = Rx<Map<String, Patient>>(PatientService.listPatients);
    super.onInit();
  }

  @override
  void onReady() {
    PatientService.listPatients.listen((newData) {
      data.value = (newData);
      if (numberOfEntries.value == data.value.length - 1) {
        numberOfEntries.value++;
      }
      update(['list_patients_screen']);
    });
    super.onReady();
  }

  void applyEntries(int value) {
    if (value >= 0 && value <= data.value.length) {
      numberOfEntries.value = value;
    }
  }

  void removeEntries(String id) {
    PatientService.listPatients.removeWhere((key, value) => key == id);
    numberOfEntries.value--;
  }

  void addEntries(Map<String, Patient> newPatient) {
    PatientService.listPatients.addAll(newPatient);
  }

  late var numberOfEntries = (data.value.length).obs;

  Future<bool> addPatientToDataBase(
      Patient patient, BuildContext context) async {
    final response = await PatientService.insertPatient(patient, context);
    if (response != null) {
      if (response['isSuccess']) {
        patient.id = response['id'];
        addEntries({patient.id: patient});
        return true;
      }
    }
    return false;
  }

  Future<bool> editPatientData(Patient patient, BuildContext context) async {
    try {
      final response = await PatientService.editPatient(patient, context);
      if (response != null) {
        if (response['isSuccess'] != null && response['isSuccess'] == true) {
          PatientService.listPatients
              .update(patient.id, (value) => value = patient);
          return true;
        }
      }
    } catch (e) {
      print('editPatientData: ${e.toString()}');
    }
    return false;
  }
}
