import 'package:admin_clinical/features/decentralization_doctor/controller/doctor_overview_controller.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../commons/widgets/custom_icon_button.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_decoration.dart';
import '../../../../services/auth_service/auth_service.dart';
import '../item_one.dart';

class FieldOverviewDoctor extends StatelessWidget {
  FieldOverviewDoctor({
    Key? key,
  }) : super(key: key);
  final controller = Get.find<DoctorOverviewController>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 15.0),
              const Text(
                'Good Morning ',
                style: TextStyle(
                    color: AppColors.headline1TextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 22.0),
              ),
              Text(
                'Dr.${AuthService.instance.user.name}',
                style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0),
              ),
              const Spacer(),
              CustomIconButton(
                onPressed: () async {
                  controller.fetchAllData();
                },
                label: Text(
                  'Refresh',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontSize: 18),
                ),
                icon: const Icon(
                  Icons.refresh_outlined,
                  color: Colors.blueGrey,
                  size: 28,
                ),
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppDecoration.primaryRadiusBorder,
                    side: const BorderSide(color: Colors.grey, width: 0.3),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 15.0, left: 15.0, right: 15.0, bottom: 10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15.0,
                      ),
                    ],
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) => Container(
                    margin: const EdgeInsets.only(
                        top: 15.0, left: 15.0, right: 15.0, bottom: 10.0),
                    padding: const EdgeInsets.all(10.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryColor[300]!,
                          Colors.deepPurple[400]!,
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Patinets',
                                    style: TextStyle(
                                      color: AppColors.headline1TextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      controller.listPatient.length.toString(),
                                      style: const TextStyle(
                                        color: AppColors.headline1TextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 70.0,
                                      ),
                                    ),
                                  ),
                                  // const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Item1(
                                        header: "New Patients",
                                        data: 40,
                                        check: true,
                                        data1: 30,
                                        size: constraints.maxHeight / 1.8,
                                      ),
                                      const SizedBox(width: 20),
                                      Item1(
                                        header: "Old Patients",
                                        data: 30,
                                        check: false,
                                        data1: 20,
                                        size: constraints.maxHeight / 1.8,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight,
                          width: constraints.maxHeight / 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: constraints.maxHeight / 2,
                                width: constraints.maxHeight / 2,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.circle,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black26, blurRadius: 10.0)
                                  ],
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        AuthService.instance.user.avt),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                            ],
                          ),
                        ),
                        const SizedBox(width: 40.0),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
