import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/form/controller/medical_form_controller.dart';
import 'package:admin_clinical/features/form/screens/service_indication_dialog.dart';
import 'package:badges/badges.dart';
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

  final _isLoading = false.obs;

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
          onPressed: () => Get.dialog(element['dialog']),
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
          () => _isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Badge(
                  position:
                      BadgePosition.topStart(top: constraints.maxHeight * 0.5),
                  badgeContent: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: backButton,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  badgeColor: Colors.grey[300]!,
                  shape: BadgeShape.circle,
                  elevation: 5,
                  child: Container(
                    padding: AppDecoration.primaryPadding,
                    decoration: AppDecoration.primaryDecorationContainer,
                    child: Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: listServiceChoice,
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.blueGrey[400],
                          width: 10,
                          thickness: 0.3,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          flex: 11,
                          child: MedicalExaminationTab(patient: patient),
                        ),
                        Column(
                          children: [
                            TextButton(
                              onPressed: () => medicalFormController
                                  .onPressedCreateButton(context),
                              child: const Text(
                                "Add",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            TextButton(
                              onPressed: () => medicalFormController
                                  .onPressedCreateButton(context),
                              child: const Text(
                                "Change",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
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
