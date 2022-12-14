import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constants/app_colors.dart';
import '../../../../services/auth_service/auth_service.dart';
import '../../controller/doctor_overview_controller.dart';
import '../list_patient_item.dart';
import '../row_consulation_item.dart';

class ListPatientField extends StatelessWidget {
  ListPatientField({
    Key? key,
  }) : super(key: key);
  final controller = Get.find<DoctorOverviewController>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.only(
            top: 10.0, left: 15.0, right: 15.0, bottom: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: AppColors.backgroundColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Patient List',
                        style: TextStyle(
                          color: AppColors.headline1TextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      InkWell(
                        onTap: () async {},
                        child: Row(
                          children: const [
                            Text(
                              "Week ",
                              style: TextStyle(
                                color: AppColors.primarySecondColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            Icon(Icons.arrow_drop_down,
                                color: AppColors.primarySecondColor),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Obx(
                    () => Expanded(
                      child: ListView(
                        children: [
                          for (int i = 0;
                              i < controller.listPatient.length;
                              i++)
                            ListPatientItem(
                                image: controller.listPatient[i].avt!,
                                name: controller.listPatient[i].name,
                                time: 2,
                                check: controller.selectPatinet.value == i,
                                press: () => controller.selectHealthPatine(i))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
                child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Consulation',
                    style: TextStyle(
                      color: AppColors.headline1TextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          width: 1,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      child: ListView(
                        // crossAxisAlignments: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12, blurRadius: 7.0)
                                  ],
                                  color: Colors.white,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage((controller
                                                .selectPatinet.value ==
                                            -1)
                                        ? 'https://thumbs.dreamstime.com/b/medical-form-list-results-data-approved-check-mark-vector-flat-cartoon-clinical-checklist-document-checkbox-133036988.jpg'
                                        : controller
                                                    .listPatient[controller
                                                        .selectPatinet.value]
                                                    .avt ==
                                                ''
                                            ? 'https://thumbs.dreamstime.com/b/medical-form-list-results-data-approved-check-mark-vector-flat-cartoon-clinical-checklist-document-checkbox-133036988.jpg'
                                            : controller
                                                .listPatient[controller
                                                    .selectPatinet.value]
                                                .avt!),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (controller.selectPatinet.value == -1)
                                          ? ''
                                          : controller
                                              .listPatient[controller
                                                  .selectPatinet.value]
                                              .name,
                                      style: const TextStyle(
                                        color: AppColors.headline1TextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.0,
                                      ),
                                    ),
                                    Text(
                                      (controller.selectPatinet.value == -1)
                                          ? ''
                                          : '${controller.listPatient[controller.selectPatinet.value].gender} - ${controller.listPatient[controller.selectPatinet.value].dob}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.more_horiz,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'Medical Form',
                            style: TextStyle(
                              color: AppColors.headline1TextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 170, 217, 255),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: const Text(
                                  'Today 10:00 AM',
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  children: const [
                                    Text(
                                      'Check',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    Icon(Icons.arrow_right, color: Colors.grey),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          const Divider(thickness: 1),
                          const SizedBox(height: 10.0),
                          RowConsultationItem(
                            header: 'Last Checked: ',
                            title: controller.lastHealthRecord.value == null
                                ? ''
                                : DateFormat().add_yMMMMEEEEd().format(
                                    controller
                                        .lastHealthRecord.value!.dateCreate),
                          ),
                          RowConsultationItem(
                            header: 'Conclusion And Treatment: ',
                            title: controller.lastHealthRecord.value == null
                                ? ''
                                : controller.lastHealthRecord.value!
                                    .conclusionAndTreatment!,
                          ),
                          RowConsultationItem(
                            header: 'Diagnostic: ',
                            title: controller.lastHealthRecord.value == null
                                ? ''
                                : controller
                                    .lastHealthRecord.value!.diagnostic!,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
