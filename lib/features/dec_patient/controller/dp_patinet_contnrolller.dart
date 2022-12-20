import 'package:admin_clinical/models/patient.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:admin_clinical/services/data_service/patient_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/doctor.dart';

class DpPatinetController extends GetxController {
  RxMap<String, Patient> listPatinet = RxMap({});
  RxList<Doctor1> listDoctor = RxList([]);
  @override
  void onInit() {
    super.onInit();
    listPatinet = PatientService.listPatients;
    listDoctor = DataService.instance.listDoctor;
  }

  //Booking appointment field
  final selectIdController = TextEditingController();
  Rx<Patient> selectPatient = Patient(
          avt: '',
          id: '',
          name: '',
          gender: '',
          address: '',
          dob: '',
          phoneNumber: '',
          status: '')
      .obs;

  void selectPatinetFunc() async {
    Patient? temp = await PatientService.searchPatientById(Get.context!,
        id: selectIdController.value.text);
    if (temp != null) {
      selectPatient.value = temp;
    }
  }

  void bookingAppointment() async {}
  void canceleForm() {
    selectPatient.value = Patient(
        avt: '',
        id: '',
        name: '',
        gender: '',
        address: '',
        dob: '',
        phoneNumber: '',
        status: '');
  }
}
