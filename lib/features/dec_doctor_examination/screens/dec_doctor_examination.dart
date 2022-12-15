import 'package:admin_clinical/constants/global_widgets/custom_button.dart';
import 'package:admin_clinical/features/dec_doctor_examination/controller/dec_doctor_examination_controller.dart';
import 'package:admin_clinical/features/patient/screens/list_patients_screen.dart';
import 'package:admin_clinical/services/auth_service/auth_service.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_decoration.dart';
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
            child: Container(
              // height: checkAnimation.value
              //     ? constraints.maxHeight * 3 / 5 - 10
              //     : 120,
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 10.0),
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
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [
                              BoxShadow(color: Colors.black26, blurRadius: 7.0)
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
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 1.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 1, color: AppColors.primaryColor),
                          borderRadius: AppDecoration.primaryRadiusBorder,
                        ),
                        child: Obx(
                          () => DropdownButton<int>(
                            underline: const SizedBox(),
                            items: controller.lRole
                                .asMap()
                                .entries
                                .map((e) => DropdownMenuItem<int>(
                                      value: e.key,
                                      child: Text(
                                        e.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                    ))
                                .toList(),
                            value: controller.selectRole.value,
                            onChanged: (value) {
                              controller.selectRole.value = value!;
                            },
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
                            if ((item.status == "Waiting Examination" &&
                                    item.departmentId ==
                                        AuthService.instance.doc.departMent &&
                                    controller.selectRole.value == 0) ||
                                (controller.selectRole.value == 1 &&
                                    item.doctorId ==
                                        AuthService.instance.doc.iDBS))
                              if (controller.listPatient
                                  .containsKey(item.patientId))
                                PatientWaitItem(
                                  examFunction: () {
                                    doctorExaminationController
                                        .examinationActionHandle(
                                            item.patientId, item.id!);
                                  },
                                  headerTitle: controller
                                      .listPatient[item.patientId]!.name,
                                  id: item.id!,
                                  title: "title",
                                  time: DateFormat()
                                      .add_yMMMMd()
                                      .format(item.dateCreate),
                                  index: 1,
                                  groupValue: check.value,
                                  func: (v) {},
                                  press: () {
                                    controller.selectRecords.value =
                                        item.patientId;
                                    controller.selectRecords1.value = item.id!;
                                  },
                                  check: controller.selectRole.value == 1,
                                  thumb: controller
                                      .listPatient[item.patientId]!.avt,
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _examinationDetailField(),
        ],
      );
    });
  }

  Widget _examinationDetailField() {
    return Obx(() => Expanded(
          flex: 1,
          child: controller.selectRecords.value != "" &&
                  controller.listPatient
                      .containsKey(controller.selectRecords.value)
              ? Container(
                  padding: const EdgeInsets.all(15.0),
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    border: Border.all(width: 1, color: AppColors.primaryColor),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10.0,
                              ),
                            ],
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(controller
                                          .listPatient[
                                              controller.selectRecords.value]!
                                          .avt !=
                                      ''
                                  ? controller
                                      .listPatient[
                                          controller.selectRecords.value]!
                                      .avt!
                                  : 'https://thumbs.dreamstime.com/b/medical-form-list-results-data-approved-check-mark-vector-flat-cartoon-clinical-checklist-document-checkbox-133036988.jpg'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Divider(thickness: 1),
                        const SizedBox(height: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RowInFo(
                              header: "Name: ",
                              title: controller
                                  .listPatient[controller.selectRecords.value]!
                                  .name,
                            ),
                            RowInFo(
                              header: "Phone Number: ",
                              title: controller
                                  .listPatient[controller.selectRecords.value]!
                                  .phoneNumber,
                            ),
                            RowInFo(
                              header: "Gender: ",
                              title: controller
                                  .listPatient[controller.selectRecords.value]!
                                  .gender,
                            ),
                            RowInFo(
                              header: "Day of Birth: ",
                              title: controller
                                  .listPatient[controller.selectRecords.value]!
                                  .dob,
                            ),
                            RowInFo(
                              header: "Email: ",
                              title: controller
                                  .listPatient[controller.selectRecords.value]!
                                  .email!,
                            ),
                            RowInFo(
                              header: "Address: ",
                              title: controller
                                  .listPatient[controller.selectRecords.value]!
                                  .address,
                            ),
                            const SizedBox(height: 10.0),
                            const Divider(thickness: 1),
                            const SizedBox(height: 10.0),
                            const Text(
                              'Examination',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            RowInfExaminationItem(
                                header: "Record ID",
                                title: controller
                                    .listRecords[
                                        controller.selectRecords1.value]!
                                    .id!),
                            RowInfExaminationItem(
                                header: "Department",
                                title: DataService.instance.getNameDepartment(
                                    controller
                                        .listRecords[
                                            controller.selectRecords1.value]!
                                        .departmentId)!),
                            RowInfExaminationItem(
                                header: "Date Create",
                                title: DateFormat().add_yMMMEd().format(
                                    controller
                                        .listRecords[
                                            controller.selectRecords1.value]!
                                        .dateCreate)),
                            RowInfExaminationItem(
                                header: "Status",
                                title: controller
                                    .listRecords[
                                        controller.selectRecords1.value]!
                                    .status),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: CustomButton(
                              text: "Check",
                              onTap: () {
                                doctorExaminationController
                                    .examinationActionHandle(
                                        controller
                                            .listRecords[controller
                                                .selectRecords1.value]!
                                            .patientId,
                                        controller
                                            .listRecords[controller
                                                .selectRecords1.value]!
                                            .id!);
                              },
                            ))
                      ]),
                )
              : const SizedBox(),
        ));
  }
}

class RowInfExaminationItem extends StatelessWidget {
  final String header;
  final String title;
  const RowInfExaminationItem(
      {super.key, required this.header, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: const TextStyle(
            color: AppColors.headline1TextColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          margin: const EdgeInsets.only(top: 5.0, bottom: 10.0),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.headline1TextColor,
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
          ),
        ),
      ],
    );
  }
}

class RowInFo extends StatelessWidget {
  final String header;
  final String title;
  const RowInFo({super.key, required this.header, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          header,
          style: const TextStyle(
            color: AppColors.headline1TextColor,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ],
    );
  }
}
