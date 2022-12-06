import 'package:admin_clinical/features/auth/widgets/custom_button.dart';
import 'package:admin_clinical/features/form/controller/medical_form_controller.dart';
import 'package:admin_clinical/features/form/screens/service_indication_dialog.dart';
import 'package:admin_clinical/services/data_service/health_record_service.dart';
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
            padding: const EdgeInsets.symmetric(vertical: 20),
          ),
          onPressed: () {
            Get.dialog(element['dialog']);
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
                          children: [
                            IconButton(
                                onPressed: backButton,
                                icon: const Icon(Icons.arrow_back_ios)),
                            ...listServiceChoice
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
                                child: CustomButton(
                                  title: "Add",
                                  onPressed: () => medicalFormController
                                      .onPressedCreateButton(context),
                                )),
                            const SizedBox(width: 10.0),
                            SizedBox(
                                height: 40,
                                child: CustomButton(
                                  title: "Update",
                                  onPressed: () => medicalFormController
                                      .onPressedCreateButton(context),
                                )),
                            const SizedBox(width: 10.0),
                            SizedBox(
                                height: 40,
                                child: CustomButton(
                                  title: "Change",
                                  onPressed: () => medicalFormController
                                      .editHealthRecordData(
                                    HealthRecordService.listHealthRecord.entries
                                        .elementAt(0)
                                        .value,
                                    context,
                                  ),
                                )),
                            const SizedBox(width: 10.0),
                            SizedBox(
                                height: 40,
                                child: CustomButton(
                                  color: Colors.red,
                                  title: "Delete",
                                  onPressed: () => medicalFormController
                                      .deleteHealthRecordData(
                                    HealthRecordService.listHealthRecord.entries
                                        .elementAt(0)
                                        .key,
                                    context,
                                  ),
                                )),
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
