import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/form/controller/medical_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'medical_examination_tab.dart';

class MedicalFormScreen extends StatelessWidget {
  MedicalFormScreen({super.key});

  final medicalFormController = Get.put(MedicalFormController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDecoration.primaryPadding,
      decoration: AppDecoration.primaryDecorationContainer,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: medicalFormController.listServiceChoice,
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
                child: MedicalExaminationTab(),
              ),
            ],
          );
        },
      ),
    );
  }
}
