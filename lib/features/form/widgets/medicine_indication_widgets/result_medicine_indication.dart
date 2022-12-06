import 'package:admin_clinical/features/overview/widgets/custom_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/medical_form_controller.dart';

class ResultMedicineIndication extends StatelessWidget {
  ResultMedicineIndication({super.key});

  final medicalFormController = Get.find<MedicalFormController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ResultMedicineTableRow(
        //   color: Colors.blueGrey[100]!,
        //   medicine: Medicine(
        //     id: "ID",
        //     name: "Name",
        //     price: 100,
        //     provider: 'Provider',
        //     type: 'Type',
        //     unit: 'Unit',

        //   ),
        // ),
        Expanded(
          child: GetBuilder<MedicalFormController>(
              assignId: true,
              id: 'ResultMedicineTableRow',
              autoRemove: false,
              builder: (controller) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    if (index != 0) {
                      return ResultMedicineTableRow(
                        medicine: medicalFormController
                            .listMedicineIndicator.value
                            .elementAt(index),
                        color: Colors.white,
                      );
                    }
                    return const SizedBox();
                  },
                  itemCount:
                      medicalFormController.listMedicineIndicator.value.length,
                );
              }),
        ),
      ],
    );
  }
}
