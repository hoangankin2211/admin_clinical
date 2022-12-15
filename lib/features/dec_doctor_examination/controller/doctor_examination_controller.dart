import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../services/data_service/patient_service.dart';
import '../../form/screens/medical_form_screen.dart';
import '../screens/dec_doctor_examination.dart';

class DoctorExaminationController extends GetxController {
  Rx<String?> selectedPatient = Rx(null);
  late PageController pageController;
  @override
  void onInit() {
    selectedPatient.value = null;
    pageController = PageController(keepPage: false);
    super.onInit();
  }

  late Rx<MedicalFormScreen?> nextPage = Rx<MedicalFormScreen?>(null);

  late final List<Widget> pages = [
    DecDoctorExamination(),
    Obx(
      () => (selectedPatient.value != null && nextPage.value != null)
          ? nextPage.value!
          : const SizedBox(),
    ),
  ];

  void examinationActionHandle(String patientId, String healthRecordId) {
    selectedPatient.value = patientId;

    nextPage.value = MedicalFormScreen(
      patient: PatientService.listPatients[selectedPatient.value]!,
      backButton: backButton,
      healthRecordId: HealthRecordService.listHealthRecord[healthRecordId],
    );

    pageController.animateToPage(1,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void backButton() {
    selectedPatient.value = null;
    nextPage.value = null;
    pageController.animateToPage(0,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
