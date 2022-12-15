import 'package:admin_clinical/constants/global_widgets/custom_button.dart';
import 'package:admin_clinical/features/dec_doctor_examination/controller/dec_doctor_examination_controller.dart';
import 'package:admin_clinical/features/patient/screens/list_patients_screen.dart';
import 'package:admin_clinical/services/auth_service/auth_service.dart';
import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../controller/doctor_examination_controller.dart';
import '../widgets/examination_item.dart';
import '../widgets/patient_wait_item.dart';
import '../widgets/row_examination_tem.dart';

// ignore: must_be_immutable
class DecDoctorExamination extends StatelessWidget {
  DecDoctorExamination({super.key});

  RxInt check = 0.obs;
  RxInt showViewMessIndex = 0.obs;
  RxBool checkAnimation = true.obs;
  final controller = Get.find<DecDoctExaminationController>();
  final doctorExaminationController = Get.find<DoctorExaminationController>();
  @override
  Widget build(BuildContext context) {
    // controller.fetchData(HealthRecordService.listHealthRecord);
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => AnimatedContainer(
                    height: checkAnimation.value
                        ? constraints.maxHeight * 3 / 5 - 10
                        : 120,
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(15.0),
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 10.0),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Examination View',
                                style: TextStyle(
                                  color: AppColors.headline1TextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                )),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12, blurRadius: 7.0)
                                  ],
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 1, color: AppColors.primaryColor),
                                ),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Search here"),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                child: const Text(
                                  'View All',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        const Divider(thickness: 1),
                        const SizedBox(height: 10.0),
                        Expanded(
                          child: Obx(
                            () => ListView(
                              children: [
                                for (var item in controller.listRecords.values)
                                  if (item.status == "Waiting Examination" &&
                                      item.departmentId ==
                                          AuthService.instance.doc.departMent)
                                    PatientWaitItem(
                                      examFunction: () {
                                        doctorExaminationController
                                            .examinationActionHandle(
                                                item.patientId, item.id!);
                                      },
                                      headerTitle: item.patientId,
                                      id: item.doctorId,
                                      title: "title",
                                      time: DateFormat()
                                          .add_yMMMMd()
                                          .format(item.dateCreate),
                                      index: 1,
                                      groupValue: check.value,
                                      func: (v) {},
                                      press: () {},
                                      check: false,
                                      thumb: '',
                                    ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: checkAnimation.value
                        ? constraints.maxHeight * 2 / 5 - 10
                        : constraints.maxHeight - 140,
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Your Examination',
                                style: TextStyle(
                                  color: AppColors.headline1TextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                )),
                            const Spacer(),
                            InkWell(
                              onTap: () =>
                                  checkAnimation.value = !checkAnimation.value,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                child: const Text(
                                  'View All',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        const Divider(thickness: 1),
                        const SizedBox(height: 10.0),
                        Expanded(
                          child: checkAnimation.value
                              ? Row(
                                  children: const [
                                    ExaminationItem(),
                                    ExaminationItem(),
                                    ExaminationItem(),
                                    ExaminationItem(),
                                  ],
                                )
                              : ListView(
                                  children: [
                                    RowExaminationItem(
                                        examId: "Examination Id 1",
                                        patientName: "Nguyen Minh Hung",
                                        time: DateTime.now()),
                                    RowExaminationItem(
                                        examId: "Examination Id 2",
                                        patientName: "Truong Huynh Duc Hoang",
                                        time: DateTime.now()),
                                    RowExaminationItem(
                                        examId: "Examination Id 3",
                                        patientName: "Nguyen Trung Hieu",
                                        time: DateTime.now()),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}
