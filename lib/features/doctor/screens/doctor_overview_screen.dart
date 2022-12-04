import 'package:admin_clinical/features/doctor/controller/doctor_main_controller.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/fake_data.dart';
import '../../../constants/global_widgets/header_list_item.dart';
import '../../../constants/global_widgets/list_item.dart';
import '../widgets/top_doctor_card.dart';

class DoctorOverView extends StatelessWidget {
  final VoidCallback tapNextPage;
  DoctorOverView({
    Key? key,
    required this.tapNextPage,
  }) : super(key: key);
  final controller = Get.find<DoctorMainController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.person,
                        color: AppColors.primaryColor, size: 30.0),
                    Text(
                      " Top Doctor",
                      style: TextStyle(
                        color: AppColors.headline1TextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TopDoctorCard(
                        name: controller.listDoctor.value[0].name!,
                        image: controller.listDoctor.value[0].avt!,
                        description:
                            controller.listDoctor.value[0].description!,
                        type: controller
                            .getDepartMent(
                                controller.listDoctor.value[0].departMent!,
                                controller.listDepartMent.value)
                            .name!,
                        ratings: 4.8,
                      ),
                      TopDoctorCard(
                        name: controller.listDoctor.value[1].name!,
                        image: controller.listDoctor.value[1].avt!,
                        description:
                            controller.listDoctor.value[1].description!,
                        type: controller
                            .getDepartMent(
                                controller.listDoctor.value[1].departMent!,
                                controller.listDepartMent.value)
                            .name!,
                        ratings: 4.8,
                      ),
                      TopDoctorCard(
                        name: controller.listDoctor.value[2].name!,
                        image: controller.listDoctor.value[2].avt!,
                        description:
                            controller.listDoctor.value[2].description!,
                        type: controller
                            .getDepartMent(
                                controller.listDoctor.value[2].departMent!,
                                controller.listDepartMent.value)
                            .name!,
                        ratings: 4.8,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.headline1TextColor.withOpacity(0.2),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Overview",
                    style: TextStyle(
                        color: AppColors.primarySecondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                  const SizedBox(height: 10.0),
                  const Divider(thickness: 1),
                  const SizedBox(height: 10.0),
                  Expanded(flex: 4, child: _allDoctoField()),
                  const SizedBox(height: 20.0),
                  Expanded(flex: 4, child: _allMedicalDepartMentField()),
                  const SizedBox(height: 40.0),
                  Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: tapNextPage,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: AppColors.primaryColor.withOpacity(0.7),
                            ),
                            child: const Text(
                              "See More",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          const Divider(thickness: 1),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Column _allMedicalDepartMentField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "All Medical Department",
          style: TextStyle(
              color: AppColors.primarySecondColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
        ),
        const SizedBox(height: 10.0),
        const HeaderListItem(
          checkHeader: true,
          titles: ["ID", "Name", "Rating", "Counting"],
        ),
        Expanded(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Obx(
                () => Column(
                  children: [
                    ...controller.listDepartMent.value.map(
                      (e) => Column(
                        children: [
                          ListItem(
                            checkHeader: true,
                            widgets: [
                              Text(
                                '${e.id}',
                                style: const TextStyle(
                                  color: AppColors.primarySecondColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                ),
                              ),
                              Text(
                                '${e.name}',
                                style: const TextStyle(
                                  color: AppColors.headline1TextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                ),
                              ),
                              Row(
                                children: const [
                                  Icon(Icons.trending_down_outlined,
                                      color: Colors.red),
                                  Expanded(
                                    child: Text(
                                      '29 %',
                                      style: const TextStyle(
                                        color: AppColors.headline1TextColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                controller
                                    .getCountDoctorInDepart(e.id!)
                                    .toString(),
                                style: const TextStyle(
                                  color: AppColors.primarySecondColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                ),
                              ),
                            ],
                          ),
                          const Divider(thickness: 1),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }

  Column _allDoctoField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "All Doctor",
          style: TextStyle(
              color: AppColors.primarySecondColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
        ),
        const SizedBox(height: 10.0),
        const HeaderListItem(
          checkHeader: true,
          titles: [
            "ID",
            "Name",
            "Rating",
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Obx(
                () => Column(
                  children: [
                    ...controller.listDoctor.value.map(
                      (e) => Column(
                        children: [
                          ListItem(
                            checkHeader: true,
                            widgets: [
                              Text(
                                e.iDBS!,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: AppColors.primarySecondColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                ),
                              ),
                              Text(
                                e.name!,
                                style: const TextStyle(
                                  color: AppColors.headline1TextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                ),
                              ),
                              Row(
                                children: const [
                                  Icon(Icons.star, color: Colors.yellowAccent),
                                  Text(
                                    '37 rating',
                                    style: TextStyle(
                                      color: AppColors.headline1TextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(thickness: 1),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
