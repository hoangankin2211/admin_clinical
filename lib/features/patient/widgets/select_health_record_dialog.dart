import 'package:admin_clinical/features/form/widgets/form_card.dart';
import 'package:admin_clinical/models/health_record.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../commons/widgets/custom_icon_button.dart';
import '../../form/widgets/medicine_indication_widgets/medicine_search_form.dart';
import '../../overview/widgets/custom_table.dart';

class SelectRecordDialog extends StatelessWidget {
  const SelectRecordDialog(
      {super.key,
      required this.records,
      required this.onTapRecord,
      required this.patientId});
  final String patientId;
  final List<HealthRecord> records;
  final Function(String, {String? healthRecordId}) onTapRecord;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5,
      child: FormCard(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconButton(
                  onPressed: () {
                    Get.back();
                    onTapRecord(patientId);
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
                Expanded(
                  child: FormCard(
                    child: Column(
                      children: [
                        const MedicineSearchFormRow(
                          customRow: [
                            {'flex': 2, 'text': 'ID'},
                            {'flex': 1, 'text': 'Date Created'},
                            {'flex': 1, 'text': 'Total Money'},
                            {'flex': 1, 'text': 'Doctor In Charge'},
                            {'flex': 1, 'text': 'Department Id'},
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.back();
                                  onTapRecord(
                                    patientId,
                                    healthRecordId: records[index].id,
                                  );
                                },
                                child: SelectHealthRecord(
                                  dateCreated: records[index]
                                      .dateCreate
                                      .toIso8601String(),
                                  departmentId: records[index].departmentId,
                                  doctorInCharge: records[index].doctorId,
                                  id: records[index].id!,
                                  totalMoney: records[index].totalMoney,
                                ),
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
      ),
    );
  }
}
