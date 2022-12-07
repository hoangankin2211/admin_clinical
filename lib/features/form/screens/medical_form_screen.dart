import 'package:admin_clinical/constants/global_widgets/notification_dialog.dart';
import 'package:admin_clinical/constants/utils.dart';
import 'package:admin_clinical/features/auth/widgets/custom_button.dart';
import 'package:admin_clinical/features/form/controller/medical_form_controller.dart';
import 'package:admin_clinical/features/form/screens/service_indication_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/patient.dart';
import 'medical_examination_tab.dart';
import 'medicine_indication_dialog.dart';

class MedicalFormScreen extends StatelessWidget {
  MedicalFormScreen(
      {super.key, required this.patient, required this.backButton});
  final Function() backButton;
  final Patient patient;
  final medicalFormController = Get.find<MedicalFormController>();

  late final List<Map<String, dynamic>> listIconAndLabel = [
    {
      'title': 'Service Indication',
      'icon': Icons.note_add_outlined,
      'dialog': ServiceIndicationDialog(patient: patient),
    },
    {
      'title': 'Medicine Indication',
      'icon': Icons.note_add_outlined,
      'dialog': MedicineIndicationDialog(patient: patient),
    },
  ];

  late final List<Widget> listServiceChoice = listIconAndLabel
      .map(
        (element) => TextButton.icon(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          ),
          onPressed: () async {
            if (medicalFormController.isCreatedForm.value) {
              final response = await Get.dialog(element['dialog']);
              if (response == null || response == false) {
                if (element['title'] == 'Service Indication') {
                  medicalFormController.listServiceIndicator.value = {};
                } else if (element['title'] == 'Medicine Indication') {
                  medicalFormController.listMedicineIndicator.value = {};
                }
              } else {
                print('here');
                if (element['title'] == 'Service Indication') {
                  medicalFormController.listServiceIndicatorFINAL =
                      medicalFormController.listServiceIndicator;
                } else if (element['title'] == 'Medicine Indication') {
                  medicalFormController.listMedicineIndicatorFINAL =
                      medicalFormController.listMedicineIndicator;
                }
              }
            } else {
              Utils.notifyHandle(
                response: false,
                successTitle: '',
                successQuestion: '',
                errorTitle:
                    'Cant not add service or medicine to health record until you create a record',
                errorQuestion: 'Error',
              );
            }
            // await ServiceDataService.instance.addNewService({
            //   'name': 'name',
            //   'price': 10.0,
            //   'departmentId': 'departmentId',
            //   'description': 'description',
            // });
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(
          () => medicalFormController.isLoading.value
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
                              onPressed: backButton,
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
                                final result = await Get.dialog(
                                  const CustomNotificationDialog(
                                      title: 'Payment',
                                      content:
                                          'Do you want to export invoice ?'),
                                );

                                if (result) {
                                } else {
                                  backButton();
                                }
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
                            child: MedicalExaminationTab(patient: patient)),
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
                              child: Obx(
                                () => CustomButton(
                                  title:
                                      medicalFormController.isCreatedForm.value
                                          ? "Update "
                                          : "Create",
                                  onPressed: () =>
                                      medicalFormController.isCreatedForm.value
                                          ? medicalFormController
                                              .onPressedUpdateButton(
                                                  medicalFormController
                                                      .currentHealthRecord
                                                      .value!,
                                                  context)
                                          : medicalFormController
                                              .onPressedCreateButton(context),
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
                                    onPressed: () async {
                                      bool result = true;
                                      if (medicalFormController
                                              .currentHealthRecord.value ==
                                          null) {
                                        result = false;
                                      } else {
                                        result = await medicalFormController
                                            .deleteHealthRecordData(
                                          medicalFormController
                                              .currentHealthRecord.value!.id!,
                                          context,
                                        );
                                      }
                                      Utils.notifyHandle(
                                        response: result,
                                        successTitle:
                                            'Delete Health Record Successfully',
                                        successQuestion: 'Successful',
                                        errorTitle:
                                            'Something happened !!! Can not delete current record or you haven\'t create the form yet',
                                        errorQuestion: 'Error',
                                      );
                                    })),
                            const SizedBox(width: 50.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
