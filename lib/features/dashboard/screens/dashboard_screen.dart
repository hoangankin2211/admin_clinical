import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/features/dashboard/controller/dashboard_controller.dart';
import 'package:admin_clinical/features/dashboard/widgets/dashboard_header.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              ConstrainedBox(
                constraints:
                    BoxConstraints(maxWidth: constraints.maxWidth * 0.13),
                child: Obx(
                  () => NavigationRail(
                    leading: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          filterQuality: FilterQuality.high,
                          'icons/app_icon.png',
                          fit: BoxFit.cover,
                          color: AppColors.primaryColor,
                          height: 60,
                          width: 60,
                        ),
                        Text(
                          'Clinic Management',
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                        )
                      ],
                    ),
                    extended: true,
                    elevation: 0.5,
                    trailing: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ListTile(
                            horizontalTitleGap: 5,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            leading: const Icon(Icons.logout_outlined,
                                color: Colors.black),
                            title: const Text('Logout'),
                            onTap: () {},
                          ),
                        ),
                      ),
                    ),
                    indicatorColor: Colors.blue[50],
                    useIndicator: true,
                    backgroundColor: Colors.white,
                    unselectedLabelTextStyle: const TextStyle(fontSize: 16),
                    selectedLabelTextStyle: const TextStyle(
                        fontSize: 16, color: AppColors.primaryColor),
                    destinations: dashboardController.listTabButton,
                    selectedIndex: dashboardController.pageIndex.value,
                    onDestinationSelected: dashboardController.switchTab,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DashboardHeader(width: constraints.maxWidth * 0.13),
                    Obx(
                      () => dashboardController.user.name == "" ||
                              DataService.instance.checkFetchData.length < 6
                          ? const Center(
                              child:
                                  CircularProgressIndicator(color: Colors.blue),
                            )
                          : Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: dashboardController.pages,
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
