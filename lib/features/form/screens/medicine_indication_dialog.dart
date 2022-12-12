import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/constants/utils.dart';
import 'package:admin_clinical/features/form/controller/medical_form_controller.dart';
import 'package:admin_clinical/features/form/screens/medical_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_decoration.dart';
import '../../../models/patient.dart';
import '../widgets/form_card.dart';
import '../widgets/medicine_indication_widgets/medicine_information_form.dart';
import '../widgets/medicine_indication_widgets/medicine_search_form.dart';
import '../widgets/medicine_indication_widgets/result_medicine_indication.dart';
import '../widgets/patient_information_form.dart';

class MedicineIndicationDialog extends StatelessWidget {
  MedicineIndicationDialog({super.key, required this.patient});
  final Patient patient;
  final medicalFormController =
      Get.find<MedicalFormController>(tag: MedicalFormScreen.tagBuilder);

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
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
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
                                        () {
                                          return medicalFormController
                                                      .currentHealthRecord
                                                      .value ==
                                                  null
                                              ? const MedicineInformationForm()
                                              : MedicineInformationForm(
                                                  id: medicalFormController
                                                      .currentHealthRecord
                                                      .value!
                                                      .id,
                                                  amount: medicalFormController
                                                      .amountMedicine.value,
                                                  createDate:
                                                      medicalFormController
                                                          .currentHealthRecord
                                                          .value!
                                                          .dateCreate,
                                                );
                                        },
                                      ),
                                    ),
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
                      const Flexible(
                        child: FormCard(
                            child: ResultMedicineIndication(
                          tagBuilder: MedicalFormScreen.tagBuilder,
                        )),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        medicalFormController.totalMoney.value =
                            medicalFormController.amountMedicine.value +
                                medicalFormController.serviceAmount.value;

                        Utils.notifyHandle(
                          response: true,
                          successTitle: 'Added Medicine',
                          successQuestion: 'Added Medicine to database',
                          errorTitle: 'Error',
                          errorQuestion: 'Some erro rs happened',
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle),
                        child: const Icon(
                          Icons.save,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Colors.redAccent, shape: BoxShape.circle),
                        child: const Icon(
                          Icons.settings_backup_restore_outlined,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
