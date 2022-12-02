import 'package:admin_clinical/models/thongtinbenhnhan.dart';
import 'package:admin_clinical/services/data_service/patient_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PatientPageController extends GetxController {
  late final Rx<Map<String, Patient>> data =
      Rx<Map<String, Patient>>(PatientService.listPatients);

  void applyEntries(int value) {
    if (value >= 1 && value <= data.value.length - 1) {
      numberOfEntries.value = value + 1;
    }
  }

  void removeEntries(String id) {
    numberOfEntries.value--;
    data.value.removeWhere((key, value) => key == id);
  }

  void addEntries(Map<String, Patient> newPatient) {
    data.value.addAll(newPatient);
    numberOfEntries.value++;
  }

  late var numberOfEntries =
      (data.value.length - 1 > 5 ? 6 : data.value.length).obs;

  Future<bool> addPatientToDataBase(
      Patient patient, BuildContext context) async {
    return await PatientService.insertPatient(patient, context);
  }
}
