import 'package:admin_clinical/services/data_service/patient_service.dart';
import 'package:get/get.dart';

import '../../../models/patient.dart';

class DecDoctExaminationController extends GetxController {
  RxMap<String, Patient> listPatients = PatientService.listPatients;
  @override
  void onInit() {
    super.onInit();
    listPatients = PatientService.listPatients;
  }
}
