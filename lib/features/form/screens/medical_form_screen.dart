import 'package:admin_clinical/constants/global_widgets/notification_dialog.dart';
import 'package:admin_clinical/constants/utils.dart';
import 'package:admin_clinical/features/auth/widgets/custom_button.dart';
import 'package:admin_clinical/features/form/controller/medical_form_controller.dart';
import 'package:admin_clinical/features/form/screens/service_indication_dialog.dart';
import 'package:admin_clinical/models/health_record.dart';
import 'package:admin_clinical/models/invoice.dart';
import 'package:admin_clinical/services/data_service/invoice_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/medicine.dart';
import '../../../models/patient.dart';
import 'medical_examination_tab.dart';
import 'medicine_indication_dialog.dart';

class MedicalFormScreen extends StatelessWidget {
  const MedicalFormScreen({
    super.key,
    required this.patient,
    required this.backButton,
    this.healthRecordId,
  });

  final Function() backButton;
  final Patient patient;
  final HealthRecord? healthRecordId;
  static const String tagBuilder = 'MedicalFormScreen';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GetBuilder<MedicalFormController>(
          init: MedicalFormController(),
          tag: tagBuilder,
          builder: (medicalFormController) {
            medicalFormController.currentHealthRecord.value = healthRecordId;
            medicalFormController.fetchIndicatorData();

            final List<Map<String, dynamic>> listIconAndLabel = [
              {
                'title': 'Service Indication',
                'icon': Icons.note_add_outlined,
                'dialog': ServiceIndicationDialog(patient: patient),
                'cacheData': medicalFormController.listServiceIndicator,
                'finalData': medicalFormController.listServiceIndicatorFINAL
              },
              {
                'title': 'Medicine Indication',
                'icon': Icons.note_add_outlined,
                'dialog': MedicineIndicationDialog(patient: patient),
                'cacheData': medicalFormController.listMedicineIndicator,
                'finalData': medicalFormController.listMedicineIndicatorFINAL
              },
            ];

            Future openDialog(
              String title,
              Widget widget,
              Map<String, dynamic> cacheData,
              List<String> finalData,
            ) async {
              final response = await Get.dialog(widget);

              if (response == null || response == false) {
                cacheData.clear();

                for (var element in finalData) {
                  if (title == 'Service Indication' &&
                      medicalFormController.services[element] != null) {
                    cacheData.putIfAbsent(element,
                        () => medicalFormController.services[element]!);
                  }
                  if (title == 'Medicine Indication') {
                    Medicine? temp = medicalFormController.medicines
                        .firstWhereOrNull((medicine) => medicine.id == element);
                    if (temp != null) {
                      cacheData.putIfAbsent(element, () => temp);
                    }
                  }
                }
              } else {
                finalData.clear();
                finalData.addAll(cacheData.keys);
              }
            }

            final List<Widget> listServiceChoice = listIconAndLabel
                .map(
                  (element) => TextButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                    ),
                    onPressed: () async {
                      if (medicalFormController.currentHealthRecord.value !=
                          null) {
                        await openDialog(
                          element['title'],
                          element['dialog'],
                          element['cacheData'],
                          element['finalData'],
                        );
                      } else {
                        Utils.notifyHandle(
                          response: false,
                          successTitle: '',
                          successQuestion: '',
                          errorTitle:
                              'Something happened !!! Please check your internet connection or press create before open this feature',
                          errorQuestion: 'ERROR',
                        );
                      }
                    },
                    icon: Icon(element['icon']),
                    label: Text(
                      element['title'],
                      style: TextStyle(
                        color: Colors.blueGrey[700],
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
                .toList();

            return !medicalFormController.initialized
                ? const Center(child: CircularProgressIndicator())
                : Stack(
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  backButton();
                                },
                                icon: const Icon(
                                  Icons.cancel_rounded,
                                  size: 40,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(width: 20),
                              ...listServiceChoice,
                              const Spacer(),
                              TextButton.icon(
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 5),
                                    backgroundColor: Colors.green),
                                onPressed: () async {
                                  medicalFormController.onPressedFinishButton(
                                      context, backButton);
                                },
                                icon: const Icon(
                                  Icons.keyboard_double_arrow_right_outlined,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Finish Examination',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Expanded(
                              child: MedicalExaminationTab(
                            patient: patient,
                          )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 40,
                                child: CustomButton(
                                  title: "Update ",
                                  onPressed: () => medicalFormController
                                      .onPressedUpdateButton(
                                    context,
                                    patient.id,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              SizedBox(
                                  height: 40,
                                  child: CustomButton(
                                    title: "Clear",
                                    onPressed: () => medicalFormController
                                        .onPressedClearButton(),
                                  )),
                              const SizedBox(width: 10.0),
                              SizedBox(
                                height: 40,
                                child: CustomButton(
                                  color: Colors.red,
                                  title: "Delete",
                                  onPressed: () => medicalFormController
                                      .onPressedDeleteButton(
                                    medicalFormController
                                        .currentHealthRecord.value!.id!,
                                    context,
                                    patient.id,
                                    backButton,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 50.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                    // ),
                  );
          },
        );
      },
    );
  }
}
