import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PatientMainController extends GetxController {
  late Rx<String?> selectedPatient;
  late Rx<HealthRecordService?> currentPatientHealthRecord;
  late PageController pageController;

  @override
  void onInit() {
    selectedPatient = Rx(null);
    currentPatientHealthRecord = Rx(null);
    pageController = PageController();
    super.onInit();
  }

  void examinationActionHandle(String patientId) {
    selectedPatient.value = patientId;
    pageController.animateToPage(1,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void backButton() {
    currentPatientHealthRecord.value = null;
    selectedPatient.value = null;
    pageController.animateToPage(0,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  @override
  void onClose() {
    pageController.dispose();
    selectedPatient.close();
    currentPatientHealthRecord.close();

    super.onClose();
  }
}
