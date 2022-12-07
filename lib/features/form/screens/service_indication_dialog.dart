import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/form/controller/medical_form_controller.dart';
import 'package:admin_clinical/features/form/widgets/form_card.dart';
import 'package:admin_clinical/features/form/widgets/patient_information_form.dart';
import 'package:admin_clinical/features/form/widgets/record_information_form.dart';
import 'package:admin_clinical/features/form/widgets/service_indication_widgets/service_indication_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/utils.dart';
import '../../../models/patient.dart';
import '../../../services/auth_service/auth_service.dart';
import '../widgets/service_indication_widgets/result_indication.dart';

class ServiceIndicationDialog extends StatelessWidget {
  ServiceIndicationDialog({super.key, required this.patient});
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
                              flex: 2,
                              child: FormCard(
                                child: Column(
                                  children: [
                                    Flexible(
                                        child: PatientInformationForm(
                                      patient: patient,
                                    )),
                                    AppWidget.primaryDivider,
                                    const SizedBox(height: 10),
                                    Flexible(
                                      child: medicalFormController
                                                  .currentHealthRecord.value !=
                                              null
                                          ? RecordInformationForm(
                                              dateCreate: DateFormat()
                                                  .add_yMMMMd()
                                                  .format(
                                                    medicalFormController
                                                        .currentHealthRecord
                                                        .value!
                                                        .dateCreate,
                                                  ),
                                              department: "Nguyen Thi Bich Nga",
                                              doctorInCharge: AuthService
                                                  .instance.user.name,
                                              id: medicalFormController
                                                  .currentHealthRecord
                                                  .value!
                                                  .id,
                                              note: medicalFormController
                                                  .currentHealthRecord
                                                  .value!
                                                  .note,
                                              status: "Not good",
                                              totalMoney: medicalFormController
                                                  .totalMoney.value,
                                            )
                                          : const RecordInformationForm(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: FormCard(
                                child: ServiceIndicationForm(),
                              ),
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        child: FormCard(
                          child: ResultIndication(),
                        ),
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
                          errorQuestion: 'Some errors happened',
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
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
