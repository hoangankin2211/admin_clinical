import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/form/controller/medical_form_controller.dart';
import 'package:admin_clinical/features/overview/widgets/custom_table.dart';
import 'package:admin_clinical/models/medicine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicineSearchForm extends StatelessWidget {
  MedicineSearchForm({super.key});

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
                        hintText: 'Enter Name of Medicine',
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
                  const SizedBox(width: 15),
                  DropdownButton<String>(
                    items: [
                      DropdownMenuItem(
                        value: 'Thuoc dau bung 1',
                        child: Text(
                          'Thuoc dau bung 1',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Thuoc dau bung 2',
                        child: Text(
                          'Thuoc dau bung 2 ',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Thuoc dau bung 3',
                        child: Text(
                          'Thuoc dau bung 3',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ],
                    value: 'Thuoc dau bung 1',
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
            ), ////////////////),////////////////),////////////////),////////////////
            const MedicineSearchFormRow(
              customRow: [
                {'flex': 1, 'text': 'Select'},
                {'flex': 2, 'text': 'ID'},
                {'flex': 1, 'text': 'Name'},
                {'flex': 1, 'text': 'Type'},
                {'flex': 1, 'text': 'Unit'},
                {'flex': 1, 'text': 'Remaining'},
              ],
            ),
            ////////////////),////////////////),////////////////),////////////////
            SizedBox(
              height: 320,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  Medicine tempMedicine =
                      medicalIndicationController.medicines.elementAt(index);
                  return GetBuilder<MedicalFormController>(
                      assignId: true,
                      autoRemove: false,
                      id: tempMedicine.id,
                      builder: (context) {
                        return MedicineTableRow(
                          isSelected: medicalIndicationController
                              .isSelected(tempMedicine.id),
                          onCheckButtonChange: medicalIndicationController
                              .onChoiceMedicineChange,
                          medicine: tempMedicine,
                          color: Colors.white,
                        );
                      });
                },
                itemCount: medicalIndicationController.medicines.length,
              ),
            )
          ],
        );
      },
    );
  }
}

class MedicineSearchFormRow extends StatelessWidget {
  const MedicineSearchFormRow({
    super.key,
    required this.customRow,
    this.width,
  });
  final double? width;
  final List<Map<String, dynamic>> customRow;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: Colors.blueGrey[200],
          borderRadius: AppDecoration.primaryRadiusBorder,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 0.5),
                color: Colors.grey[200]!,
                blurRadius: 2)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 5),
          ...customRow.map(
            (element) => Expanded(
              flex: element['flex'],
              child: Text(
                element['text'],
                style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(width: width ?? 0),
        ],
      ),
    );
  }
}
