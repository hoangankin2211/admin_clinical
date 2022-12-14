import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/models/health_record.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../commons/widgets/custom_icon_button.dart';
import '../../../services/data_service/patient_service.dart';
import '../../form/widgets/medicine_indication_widgets/medicine_search_form.dart';
import '../../overview/widgets/custom_table.dart';
import 'create_healthRecord_dialog.dart';

class SelectRecordDialog extends StatelessWidget {
  const SelectRecordDialog(
      {super.key, required this.records, required this.patientId});
  final String patientId;
  final List<HealthRecord> records;

  void onTapRecord(String patientId, BuildContext context) {
    Get.dialog(
      CreateHealthRecordDialog(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.4,
        patient: PatientService.listPatients[patientId]!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5,
      backgroundColor: Colors.transparent,
      child: Container(
        width: Get.width / 1.3,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          border: Border.all(width: 2, color: AppColors.primaryColor),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.file_copy, color: AppColors.primaryColor),
                  const Text(' Examination',
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0)),
                  const Spacer(),
                  CustomIconButton(
                    onPressed: () {
                      Get.back();
                      onTapRecord(patientId, context);
                    },
                    label: const Text(
                      'Add New Record',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    icon: const Icon(
                      Icons.add_outlined,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Expanded(
                child: Container(
                  padding: AppDecoration.primaryPadding,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(color: Colors.)
                    borderRadius: AppDecoration.primaryRadiusBorder,
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 7.0)
                    ],
                  ),
                  child: Column(
                    children: [
                      const MedicineSearchFormRow(
                        customRow: [
                          {'flex': 1, 'text': 'ID'},
                          {'flex': 1, 'text': 'Date Created'},
                          {'flex': 1, 'text': 'Total Money'},
                          {'flex': 1, 'text': 'Doctor In Charge'},
                          {'flex': 1, 'text': 'Department Id'},
                          {'flex': 1, 'text': ''},
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return SelectHealthRecord(
                              dateCreated:
                                  records[index].dateCreate.toIso8601String(),
                              departmentId: records[index].departmentId,
                              doctorInCharge: records[index].doctorId,
                              id: records[index].id!,
                              totalMoney: records[index].totalMoney,
                              deleteCallback: () {},
                              viewCallback: () {
                                Get.back();
                                onTapRecord(
                                    patientId,
                                    // healthRecordId: records[index].id,
                                    context);
                              },
                            );
                          },
                          itemCount: records.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
