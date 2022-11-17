import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/doctor/screens/doctor_main_screen.dart';
import 'package:admin_clinical/features/doctor/screens/view_all_doctor.dart';
import 'package:admin_clinical/features/form/screens/medical_examination_tab.dart';
import 'package:admin_clinical/features/form/screens/medical_form_screen.dart';
import 'package:admin_clinical/features/overview/screens/overview_screen.dart';
import 'package:admin_clinical/features/settings/screen/setting_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var pageIndex = 0.obs;

  late final Widget pages = Obx(
    () => IndexedStack(
      index: pageIndex.value,
      alignment: Alignment.topCenter,
      children: listPage,
    ),
  );

  late final List<NavigationRailDestination> listTabButton =
      AppWidget.listNavigatorTab
          .map(
            (e) => NavigationRailDestination(
              icon: Icon(e['icon'] as IconData),
              label: Text(e['label'] as String),
            ),
          )
          .toList();

  late final List<Widget> listPage = [
    Text("Overview"),
    DoctorMainScreen(),
    OverviewScreen(),
    MedicalFormScreen(), // ListPatientScreen(),
    SettingMainScreen(),
  ];

  void switchTab(int index) {
    if (index >= 0 && index < listPage.length) {
      pageIndex.value = index;
    }
  }
}
