import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/health_record.dart';
import '../../../services/data_service/patient_service.dart';
import '../../form/screens/medical_form_screen.dart';
import '../screens/list_patients_screen.dart';

class PatientMainController extends GetxController {
  String? selectedPatient;
  late PageController pageController;
  @override
  void onInit() {
    selectedPatient = null;
    pageController = PageController(keepPage: false);
    super.onInit();
  }

  late Rx<Widget> nextPage = Rx<Widget>(
    MedicalFormScreen(
      patient: PatientService.listPatients[selectedPatient!]!,
      backButton: backButton,
    ),
  );

  late final List<Widget> pages = [
    ListPatientScreen(examinationActionHandle: examinationActionHandle),
    Obx(
      () => selectedPatient != null ? nextPage.value : const SizedBox(),
    ),
  ];

  void examinationActionHandle(String patientId, {String? healthRecordId}) {
    selectedPatient = patientId;

    if (healthRecordId != null) {
      nextPage.value = MedicalFormScreen(
        patient: PatientService.listPatients[selectedPatient!]!,
        backButton: backButton,
        healthRecordId: HealthRecordService.listHealthRecord[healthRecordId],
      );
    }

    pageController.animateToPage(1,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void backButton() {
    selectedPatient = null;
    pageController.animateToPage(0,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
