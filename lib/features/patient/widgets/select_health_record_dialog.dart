import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/patient/widgets/health_record_detail.dart';
import 'package:admin_clinical/models/health_record.dart';
import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../commons/widgets/custom_icon_button.dart';
import '../../../constants/utils.dart';
import '../../../services/data_service/patient_service.dart';
import '../../form/widgets/medicine_indication_widgets/medicine_search_form.dart';
import '../../overview/widgets/custom_table.dart';
import 'create_healthRecord_dialog.dart';

// ignore: must_be_immutable
class SelectRecordDialog extends StatelessWidget {
  const SelectRecordDialog({
    super.key,
    required this.patientId,
    required this.deleteButton,
  });
  final String patientId;
  final Future<bool> Function(String id, BuildContext context, String patientId)
      deleteButton;

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
    var isLoading = false.obs;
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
            child: Obx(
              () => isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.file_copy,
                                color: AppColors.primaryColor),
                            const Text(
                              ' Examination',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            const Spacer(),
                            CustomIconButton(
                              onPressed: () => onTapRecord(patientId, context),
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
                              borderRadius: AppDecoration.primaryRadiusBorder,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black26, blurRadius: 7.0)
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
                                  child: Obx(
                                    () => ListView.builder(
                                      itemBuilder: (context, index) {
                                        HealthRecord temp = HealthRecordService
                                                .listHealthRecord[
                                            PatientService
                                                .listPatients[patientId]!
                                                .healthRecord![index]]!;
                                        return SelectHealthRecord(
                                          dateCreated: temp.dateCreate,
                                          departmentId: temp.departmentId,
                                          doctorInCharge: temp.doctorId,
                                          id: temp.id!,
                                          totalMoney: temp.totalMoney,
                                          deleteCallback: () async {
                                            isLoading.value = true;

                                            bool result = await deleteButton(
                                                temp.id!, context, patientId);
                                            isLoading.value = false;

                                            await Utils.notifyHandle(
                                              isClose: false,
                                              response: result,
                                              successTitle: 'Success',
                                              successQuestion:
                                                  'Delete Health Record Success',
                                              errorTitle: 'ERROR',
                                              errorQuestion:
                                                  'Something occurred !!! Please check your internet connection',
                                            );
                                          },
                                          viewCallback: () async {
                                            await Get.dialog(
                                              Dialog(
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.9,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: HealthRecordDetail(
                                                    healthRecord: temp,
                                                    patient: PatientService
                                                            .listPatients[
                                                        patientId]!,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      itemCount: PatientService
                                          .listPatients[patientId]!
                                          .healthRecord!
                                          .length,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            )),
      ),
    );
  }
}
