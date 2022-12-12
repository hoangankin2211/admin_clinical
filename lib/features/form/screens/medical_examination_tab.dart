import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/constants/utils.dart';
import 'package:admin_clinical/features/form/controller/medical_form_controller.dart';
import 'package:admin_clinical/features/form/screens/medical_form_screen.dart';
import 'package:admin_clinical/features/form/widgets/examination_information_form.dart';
import 'package:admin_clinical/features/form/widgets/record_information_form.dart';
import 'package:admin_clinical/features/form/widgets/patient_information_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/patient.dart';
import '../../../services/auth_service/auth_service.dart';

// ignore: must_be_immutable
class MedicalExaminationTab extends StatelessWidget {
  MedicalExaminationTab({super.key, required this.patient});
  static const String getBuilderId = 'MedicalExaminationTab';
  final Patient patient;
  final medicalFormController =
      Get.find<MedicalFormController>(tag: MedicalFormScreen.tagBuilder);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDecoration.primaryPadding,
      margin: const EdgeInsets.all(6.0),
      decoration: AppDecoration.primaryDecorationContainer1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: PatientInformationForm(patient: patient),
                    ),
                    VerticalDivider(
                      color: Colors.blueGrey[400],
                      thickness: 0.3,
                    ),
                    Expanded(
                      child: Obx(() => (medicalFormController
                                  .currentHealthRecord.value !=
                              null
                          ? RecordInformationForm(
                              dateCreate: DateFormat().add_yMMMd().format(
                                  medicalFormController
                                      .currentHealthRecord.value!.dateCreate),
                              department: "Neurology",
                              doctorInCharge: AuthService.instance.user.name,
                              id: medicalFormController
                                  .currentHealthRecord.value!.id,
                              note: medicalFormController
                                  .currentHealthRecord.value!.note,
                              status: "Not good",
                              totalMoney:
                                  medicalFormController.totalMoney.value,
                            )
                          : const RecordInformationForm())),
                    ),
                  ],
                ),
              ),
              AppWidget.primaryDivider,
              const SizedBox(height: 5),
              Flexible(
                flex: 3,
                child: ExaminationInformationForm(
                  textController: medicalFormController.textController,
                  examField: Utils.examField,
                  formKey: medicalFormController.formKey,
                  measureField: Utils.measureField,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
