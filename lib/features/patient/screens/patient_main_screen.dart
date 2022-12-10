import 'package:admin_clinical/features/patient/controller/patient_main_controller.dart';
import 'package:admin_clinical/services/data_service/patient_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../form/screens/medical_form_screen.dart';
import 'list_patients_screen.dart';

// ignore: must_be_immutable
class PatientMainScreen extends StatelessWidget {
  PatientMainScreen({super.key});

  final patientMainController = Get.put(PatientMainController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => PageView(
        controller: patientMainController.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ListPatientScreen(
              examinationActionHandle:
                  patientMainController.examinationActionHandle),
          Obx(
            () => patientMainController.selectedPatient.value != null
                ? MedicalFormScreen(
                    patient: PatientService.listPatients[
                        patientMainController.selectedPatient.value!]!,
                    backButton: patientMainController.backButton,
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
