import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/clinical_room/screens/clinical_room_screen.dart';
import 'package:admin_clinical/features/doctor/screens/doctor_main_screen.dart';
import 'package:admin_clinical/features/form/screens/medical_form_screen.dart';
import 'package:admin_clinical/features/invoice/screens/invoice_view_screen.dart';
import 'package:admin_clinical/features/invoice/screens/verify_invoice_information_screen.dart';
import 'package:admin_clinical/features/medicine/screens/medicine_screen.dart';
import 'package:admin_clinical/features/overview/screens/overview_screen.dart';
import 'package:admin_clinical/features/patient/screens/list_patients_screen.dart';
import 'package:admin_clinical/features/settings/screen/setting_main_screen.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/user.dart';
import '../../../services/auth_service/auth_service.dart';

class DashboardController extends GetxController {
  var pageIndex = 0.obs;
  late final Widget pages;
  final Rx<User> _user = Rx<User>(
    User(
      name: '',
      email: '',
      password: '',
      address: '',
      type: '',
      id: '',
      token: '',
      gender: '',
      phoneNumber: '',
      dateBorn: DateTime.now(),
      avt: '',
    ),
  );

  User get user => _user.value;

  @override
  void onInit() async {
    super.onInit();
    await fetchAllBasicData();
    await setUserIfNeed();
    pages = Obx(
      () => IndexedStack(
        index: pageIndex.value,
        alignment: Alignment.topCenter,
        children: listPage,
      ),
    );
  }

  setUserIfNeed() async {
    bool check = await AuthService.instance.getUserData();
    if (check) {
      _user.value = AuthService.instance.user;
      // print("Get all data success");
    }
  }

  fetchAllBasicData() async {
    DataService.instance.fetchAllData();
  }

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
    OverviewScreen(),
    ListPatientScreen(),
    DoctorMainScreen(),
    InvoiceView(),
    MedicalFormScreen(),
    ClinicalRoom(),
    MedicineScreen(),
    const SettingMainScreen(),
  ];

  void switchTab(int index) {
    if (index >= 0 && index < listPage.length) {
      pageIndex.value = index;
    }
  }
}
