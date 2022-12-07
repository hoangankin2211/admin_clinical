import 'package:admin_clinical/features/form/widgets/form_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_decoration.dart';
import '../../../overview/widgets/custom_table.dart';
import '../../controller/medical_form_controller.dart';
import '../medicine_indication_widgets/medicine_search_form.dart';

class ResultIndication extends StatelessWidget {
  ResultIndication({super.key});

  final medicalIndicationController = Get.find<MedicalFormController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FormCard(
          child: Column(
            children: [
              const MedicineSearchFormRow(
                customRow: [
                  {'flex': 2, 'text': 'ID'},
                  {'flex': 1, 'text': 'Name'},
                  {'flex': 1, 'text': 'Department ID'},
                  {'flex': 1, 'text': 'Price'},
                  {'flex': 1, 'text': 'Description'},
                ],
                width: 48,
              ),
              Expanded(
                child: GetBuilder<MedicalFormController>(
                  assignId: true,
                  id: 'resultService',
                  autoRemove: false,
                  builder: (controller) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return ResultServiceTableRow(
                          deleteServiceChoice:
                              medicalIndicationController.onChoiceServiceChange,
                          color: Colors.white,
                          service: medicalIndicationController
                              .listServiceIndicator.entries
                              .elementAt(index)
                              .value,
                        );
                      },
                      itemCount: medicalIndicationController
                          .listServiceIndicator.length,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
