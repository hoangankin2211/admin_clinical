import 'package:admin_clinical/features/form/controller/medical_form_controller.dart';
import 'package:admin_clinical/features/patient/controller/patient_page_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/patient.dart';
import '../../form/screens/medical_form_screen.dart';
import 'list_patients_screen.dart';

// ignore: must_be_immutable
class PatientMainScreen extends StatelessWidget {
  PatientMainScreen({super.key});

  final patientPageController = Get.put(PatientPageController());
  final medicalFormController = Get.put(MedicalFormController());
  PageController pageController = PageController();
  void examinationActionHandle(String patientId) {
    patientPageController.selectedPatient.value = patientId;
    pageController.animateToPage(1,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void backButton() {
    medicalFormController.currentHealthRecord.value = null;
    patientPageController.selectedPatient.value = null;
    pageController.animateToPage(0,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ListPatientScreen(examinationActionHandle: examinationActionHandle),
          Obx(
            () => MedicalFormScreen(
              patient: patientPageController.selectedPatient.value != null
                  ? patientPageController.data.value[
                          patientPageController.selectedPatient.value!] ??
                      Patient(
                        address: '',
                        dob: '',
                        gender: '',
                        id: '',
                        name: '',
                        phoneNumber: '',
                        status: '',
                      )
                  : Patient(
                      address: '',
                      dob: '',
                      gender: '',
                      id: '',
                      name: '',
                      phoneNumber: '',
                      status: '',
                    ),
              backButton: backButton,
            ),
          ),
        ],
      ),
    );
  }
}
