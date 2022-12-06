import 'package:admin_clinical/features/form/controller/medical_form_controller.dart';
import 'package:admin_clinical/features/form/widgets/form_card.dart';
import 'package:admin_clinical/features/form/widgets/medicine_indication_widgets/medicine_information_form.dart';
import 'package:admin_clinical/features/form/widgets/medicine_indication_widgets/medicine_search_form.dart';
import 'package:admin_clinical/features/form/widgets/medicine_indication_widgets/result_medicine_indication.dart';
import 'package:admin_clinical/features/form/widgets/patient_information_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_decoration.dart';
import '../../../models/patient.dart';

class MedicineIndicationDialog extends StatelessWidget {
  MedicineIndicationDialog({super.key, required this.patient});
  final Patient patient;
  final medicalFormController = Get.find<MedicalFormController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: AppDecoration.primaryRadiusBorder,
              side: AppDecoration.primarySecondBorder,
            ),
            child: Container(
              decoration: AppDecoration.primaryDecorationContainer,
              child: Column(
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(
                          flex: 45,
                          child: FormCard(
                            child: Column(
                              children: [
                                Flexible(
                                    child: PatientInformationForm(
                                  patient: patient,
                                )),
                                const SizedBox(height: 5),
                                AppWidget.primaryDivider,
                                const SizedBox(height: 5),
                                Flexible(
                                    child: Obx(
                                  () => MedicineInformationForm(
                                    id: medicalFormController
                                                .currentHealthRecord.value !=
                                            null
                                        ? medicalFormController
                                            .currentHealthRecord.value!.id
                                        : null,
                                    amount: medicalFormController
                                        .amountMedicine.value,
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 100,
                          child: FormCard(child: MedicineSearchForm()),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    child: FormCard(child: ResultMedicineIndication()),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
