import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/overview/screens/overview_screen.dart';
import 'package:admin_clinical/features/patient/screens/patient_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var pageIndex = 0.obs;

  late final Widget pages = Obx(() => IndexedStack(
        index: pageIndex.value,
        alignment: Alignment.topCenter,
        children: listPage,
      ));

  late final List<NavigationRailDestination> listTabButton =
      AppWidget.listNavigatorTab
          .map(
            (e) => NavigationRailDestination(
              icon: Icon(e['icon'] as IconData),
              label: Text(e['label'] as String),
            ),
          )
          .toList();

  late final List<Widget> listPage = const [
    OverviewScreen(),
    PatientScreen(),
    Text('Payment'),
    Text('Medical Form'),
    Text('Settings'),
  ];

  void switchTab(int index) {
    if (index >= 0 && index < listPage.length) {
      pageIndex.value = index;
    }
  }
}
