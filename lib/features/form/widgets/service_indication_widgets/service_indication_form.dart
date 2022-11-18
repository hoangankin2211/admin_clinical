import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/form/controller/medical_form_controller.dart';
import 'package:admin_clinical/features/overview/widgets/custom_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceIndicationForm extends StatelessWidget {
  ServiceIndicationForm({super.key});

  final medicalIndicationController = Get.find<MedicalFormController>();
  late final List<Map<String, dynamic>> rowData =
      medicalIndicationController.rowServiceIndicationData;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: const EdgeInsets.all(10),
          padding: AppDecoration.primaryPadding,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 0.3,
            ),
            borderRadius: AppDecoration.primaryRadiusBorder,
            boxShadow: AppDecoration.elevationContainer,
          ),
          child: Column(
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
                                color: AppColors.primarySecondColor,
                                width: 0.2),
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
              ServiceTableRow(
                name: rowData[0]['name'],
                id: rowData[0]['id'],
                color: Colors.blueGrey[100]!,
                departmentID: rowData[0]['departmentID'],
                isSelected: (rowData[0]['isSelected'] as RxBool).value,
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const SizedBox();
                    } else {
                      return Obx(
                        () => ServiceTableRow(
                          onCheckButtonChange: (value) =>
                              medicalIndicationController.onChoiceServiceChange(
                                  value, index),
                          name: rowData[index]['name'],
                          id: rowData[index]['id'],
                          color: Colors.white,
                          departmentID: rowData[index]['departmentID'],
                          isSelected:
                              (rowData[index]['isSelected'] as Rx<bool>).value,
                        ),
                      );
                    }
                  },
                  itemCount: rowData.length,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
