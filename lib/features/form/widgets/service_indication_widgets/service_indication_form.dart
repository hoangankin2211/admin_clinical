import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/form/controller/medical_form_controller.dart';
import 'package:admin_clinical/features/form/widgets/form_card.dart';
import 'package:admin_clinical/features/overview/widgets/custom_table.dart';
import 'package:admin_clinical/models/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../medicine_indication_widgets/medicine_search_form.dart';

class ServiceIndicationForm extends StatelessWidget {
  ServiceIndicationForm({super.key});

  final medicalIndicationController = Get.find<MedicalFormController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(bottom: 10),
                        border: OutlineInputBorder(
                          borderRadius: AppDecoration.primaryRadiusBorder,
                          borderSide: const BorderSide(
                              color: AppColors.primarySecondColor, width: 0.2),
                        ),
                        hintText: 'Enter Name of Service',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.blueGrey[400]),
                        prefixIcon: const Icon(
                          Icons.search_outlined,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    items: [
                      DropdownMenuItem(
                        value: 'Sieu am am dao 1',
                        child: Text(
                          'Sieu am am dao 1',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Sieu am am dao 2',
                        child: Text(
                          'Sieu am am dao 2 ',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Sieu am am dao 3',
                        child: Text(
                          'Sieu am am dao 3',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ],
                    value: 'Sieu am am dao 1',
                    onChanged: (value) {},
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Select All',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(width: 5),
                  Checkbox(value: false, onChanged: (value) {}),
                ],
              ),
            ),
            const MedicineSearchFormRow(
              customRow: [
                {'flex': 1, 'text': 'Select'},
                {'flex': 2, 'text': 'ID'},
                {'flex': 1, 'text': 'Name'},
                {'flex': 1, 'text': 'Department ID'},
                {'flex': 1, 'text': 'Description'},
              ],
            ),
            ////////////////),////////////////),////////////////),////////////////
            SizedBox(
              height: 320,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  Service tempService = medicalIndicationController
                      .services.entries
                      .elementAt(index)
                      .value;
                  return GetBuilder<MedicalFormController>(
                      assignId: true,
                      autoRemove: false,
                      id: tempService.id,
                      builder: (controller) {
                        return ServiceTableRow(
                          isSelected: medicalIndicationController
                              .isSelectedService(tempService.id ?? " "),
                          onCheckButtonChange:
                              medicalIndicationController.onChoiceServiceChange,
                          service: tempService,
                          color: Colors.white,
                        );
                      });
                },
                itemCount: medicalIndicationController.services.length,
              ),
            )
          ],
        );
      },
    );
  }
}
