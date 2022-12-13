import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/clinical_room/screens/clinical_room_screen.dart';
import 'package:admin_clinical/features/decentralization_doctor/screen/doctor_dec_overview.dart';
import 'package:admin_clinical/features/doctor/screens/doctor_main_screen.dart';
import 'package:admin_clinical/features/invoice/controllers/invoice_controller.dart';
import 'package:admin_clinical/features/invoice/screens/invoice_view_screen.dart';
import 'package:admin_clinical/features/medicine/screens/medicine_screen.dart';
import 'package:admin_clinical/features/overview/screens/overview_screen.dart';
import 'package:admin_clinical/features/patient/controller/patient_page_controller.dart';
import 'package:admin_clinical/features/patient/screens/patient_detail_screen.dart';
import 'package:admin_clinical/features/patient/screens/patient_main_screen.dart';
import 'package:admin_clinical/features/settings/screen/setting_main_screen.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/user.dart';
import '../../../services/auth_service/auth_service.dart';
import '../../clinical_room/controller/clinical_room_controller.dart';
import '../../decentralization_doctor/controller/doctor_overview_controller.dart';
import '../../doctor/controller/doctor_main_controller.dart';
import '../../medicine/controller/medicine_controller.dart';
import '../../overview/controller/overview_controller.dart';
import '../../patient/controller/patient_main_controller.dart';
import '../../settings/controller/settings_controller.dart';

class DashboardController extends GetxController {
  var pageIndex = 0.obs;
  final Rx<Widget?> pages = Rx<Widget?>(null);
  final Rx<User?> _user = Rx<User?>(AuthService.instance.user);

  User? get user => _user.value;

  // @override
  // void onInit() async {
  //   _user.listen((user) {
  //     if (user != null) {
  //       update(['DashboardScreen']);
  //     }
  //   });
  //   super.onInit();
  // }

  @override
  void onReady() async {
    bool response = await setUserIfNeed();
    response = await fetchAllBasicData();
    if (response) {
      print(response);
      response = await _initializeAllController();
      if (response) {
        print(response);
        Future(
          () => pages.value = Obx(
            () => IndexedStack(
              index: pageIndex.value,
              alignment: Alignment.topCenter,
              children: listPage,
            ),
          ),
        ).then((_) => update(['DashboardScreen']));
      }
    }

    super.onReady();
  }

  Future<bool> setUserIfNeed() async {
    bool check = await AuthService.instance.getUserData();
    if (check) {
      _user.value = AuthService.instance.user;
    }
    return true;
  }

  Future<bool> _initializeAllController() async {
    await Get.putAsync(() => Future.value(DoctorOverviewController()));
    await Get.putAsync(() => Future.value(OverviewController()));
    await Get.putAsync(() => Future.value(DoctorMainController()));
    await Get.putAsync(() => Future.value(PatientMainController()));
    await Get.putAsync(() => Future.value(PatientPageController()));
    await Get.putAsync(() => Future.value(InvoiceController()));
    await Get.putAsync(() => Future.value(ClinicalRoomController()));
    await Get.putAsync(() => Future.value(MedicineController()));
    await Get.putAsync(() => Future.value(SettingController()));
    return true;
  }

  Future<bool> fetchAllBasicData() async {
    return await DataService.instance.fetchAllData();
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
    DoctorDecOverview(),
    OverviewScreen(),
    PatientMainScreen(),
    DoctorMainScreen(),
    InvoiceView(),
    ClinicalRoom(),
    const MedicineScreen(),
    const SettingMainScreen(),
  ];

  void switchTab(int index) {
    if (index >= 0 && index < listPage.length) {
      pageIndex.value = index;
    }
  }
}
