import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/features/dashboard/controller/dashboard_controller.dart';
import 'package:admin_clinical/features/dashboard/widgets/dashboard_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return GetBuilder<DashboardController>(
            init: DashboardController(),
            autoRemove: false,
            assignId: true,
            id: 'DashboardScreen',
            builder: (dashboardController) {
              if (dashboardController.user == null ||
                  dashboardController.pages.value == null) {
                return const Center(child: CircularProgressIndicator());
              }
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
                              'assets/icons/app_icon.png',
                              fit: BoxFit.cover,
                              color: AppColors.primaryColor,
                              height: 60,
                              width: 60,
                            ),
                            Text(
                              'Clinic Management',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
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
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
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
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: dashboardController.pages.value,
                            ),
                          ),
                        ]),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
