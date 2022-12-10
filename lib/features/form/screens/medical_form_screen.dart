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

class MedicalFormScreen extends StatefulWidget {
  const MedicalFormScreen({
    super.key,
    required this.patient,
    required this.backButton,
  });

  final Function() backButton;
  final Patient patient;

  @override
  State<MedicalFormScreen> createState() => _MedicalFormScreenState();
}

class _MedicalFormScreenState extends State<MedicalFormScreen> {
  final medicalFormController = Get.put(MedicalFormController());

  late final List<Map<String, dynamic>> listIconAndLabel = [
    {
      'title': 'Service Indication',
      'icon': Icons.note_add_outlined,
      'dialog': ServiceIndicationDialog(patient: widget.patient),
      'cacheData': medicalFormController.listServiceIndicator,
      'finalData': medicalFormController.listServiceIndicatorFINAL
    },
    {
      'title': 'Medicine Indication',
      'icon': Icons.note_add_outlined,
      'dialog': MedicineIndicationDialog(patient: widget.patient),
      'cacheData': medicalFormController.listMedicineIndicator,
      'finalData': medicalFormController.listMedicineIndicatorFINAL
    },
  ];

  Future _openDialog(Widget widget, Map<String, dynamic> cacheData,
      List<String> finalData) async {
    final response = await Get.dialog(widget);

    if (response == null || response == false) {
      cacheData.clear();
      for (var element in finalData) {
        if (medicalFormController.services[element] != null) {
          cacheData.putIfAbsent(
            element,
            () => medicalFormController.services[element]!,
          );
        }
      }
    } else {
      finalData.clear();
      finalData.addAll(cacheData.keys);
    }
  }

  late final List<Widget> listServiceChoice = listIconAndLabel
      .map(
        (element) => TextButton.icon(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          ),
          onPressed: () async {
            if (medicalFormController.isCreatedForm.value) {
              await _openDialog(element['dialog'], element['cacheData'],
                  element['finalData']);
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

  @override
  void dispose() {
    medicalFormController.dispose();
    super.dispose();
  }

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
                              onPressed: widget.backButton,
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
                                    content: 'Do you want to export invoice ?',
                                  ),
                                );

                                // ignore: curly_braces_in_flow_control_structures
                                if (result != null) {
                                  if (result as bool) {
                                  } else {
                                    widget.backButton();
                                  }
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
                            child:
                                MedicalExaminationTab(patient: widget.patient)),
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
                                              .onPressedUpdateButton(context)
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
                                },
                              ),
                            ),
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
