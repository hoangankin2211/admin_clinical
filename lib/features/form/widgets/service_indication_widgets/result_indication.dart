import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_decoration.dart';
import '../../../overview/widgets/custom_table.dart';
import '../../controller/medical_form_controller.dart';

class ResultIndication extends StatelessWidget {
  ResultIndication({super.key});

  final medicalIndicationController = Get.find<MedicalFormController>();

  late final List<Map<String, dynamic>> rowData =
      medicalIndicationController.resultIndicationRowData;

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
            children: [
              ResultServiceTableRow(
                amountPrice: rowData[0]['amountPrice'],
                pricePerUnit: rowData[0]['pricePerUnit'],
                departmentCharge: rowData[0]['departmentCharge'],
                amount: rowData[0]['amount'],
                name: rowData[0]['name'],
                id: rowData[0]['id'],
                color: Colors.blueGrey[100]!,
                departmentID: rowData[0]['departmentID'],
              ),
              Expanded(
                child: GetBuilder<MedicalFormController>(
                    assignId: true,
                    id: 'resultService',
                    autoRemove: false,
                    builder: (controller) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          if (index != 0) {
                            return ResultServiceTableRow(
                              amountPrice: rowData[index]['amountPrice'],
                              pricePerUnit: rowData[index]['pricePerUnit'],
                              departmentCharge: rowData[index]
                                  ['departmentCharge'],
                              amount: rowData[index]['amount'],
                              name: rowData[index]['name'],
                              id: rowData[index]['id'],
                              color: Colors.white,
                              departmentID: rowData[index]['departmentID'],
                            );
                          }
                          return const SizedBox();
                        },
                        itemCount: rowData.length,
                      );
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}
