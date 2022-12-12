import 'package:admin_clinical/features/overview/widgets/custom_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/medical_form_controller.dart';
import 'medicine_search_form.dart';

class ResultMedicineIndication extends StatelessWidget {
  const ResultMedicineIndication({super.key, required this.tagBuilder});
  final String tagBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MedicineSearchFormRow(
          customRow: [
            {'flex': 2, 'text': 'ID'},
            {'flex': 1, 'text': 'Name'},
            {'flex': 1, 'text': 'Amount Price'},
            {'flex': 1, 'text': 'Original Price'},
            {'flex': 1, 'text': 'Type'},
            {'flex': 1, 'text': 'Description'},
            {'flex': 1, 'text': 'Unit'},
            {'flex': 1, 'text': 'Remaining'},
          ],
          width: 48,
        ),
        Expanded(
          child: GetBuilder<MedicalFormController>(
            assignId: true,
            id: 'ResultMedicineTableRow',
            autoRemove: false,
            builder: (medicalIndicationController) {
              // medicalIndicationController.fetchIndicatorMedicine();
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ResultMedicineTableRow(
                    deleteMedicineChoice:
                        medicalIndicationController.onChoiceMedicineChange,
                    medicine: medicalIndicationController
                        .listMedicineIndicator.entries
                        .elementAt(index)
                        .value,
                    color: Colors.white,
                  );
                },
                itemCount:
                    medicalIndicationController.listMedicineIndicator.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
