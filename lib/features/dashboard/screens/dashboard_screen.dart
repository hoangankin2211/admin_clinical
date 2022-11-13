import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/features/dashboard/controller/dashboard_controller.dart';
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
                    BoxConstraints(maxWidth: constraints.maxWidth * 0.125),
                child: Obx(
                  () => NavigationRail(
                    leading: const Icon(Icons.local_hospital_outlined),
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
              const VerticalDivider(
                width: 0.5,
                thickness: 0.2,
                color: Colors.grey,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: dashboardController.pages,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
