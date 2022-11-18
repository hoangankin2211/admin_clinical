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
            ),
            MedicineTableRow(
              color: Colors.blueGrey[100]!,
              medicine: Medicine(
                id: "ID",
                name: "Name",
                price: 100,
                provider: 'Provider',
                type: 'Type',
                unit: 'Unit',
              ),
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return MedicineTableRow(
                    onCheckButtonChange:
                        medicalIndicationController.onChoiceMedicineChange,
                    medicine:
                        medicalIndicationController.medicines.elementAt(index),
                    color: Colors.white,
                  );
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
