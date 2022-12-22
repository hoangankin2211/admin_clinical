import 'package:admin_clinical/features/clinical_room/screens/clinical_room_screen.dart';
import 'package:admin_clinical/features/decentralization_doctor/screen/doctor_dec_overview.dart';
import 'package:admin_clinical/features/doctor/screens/doctor_main_screen.dart';
import 'package:admin_clinical/features/form/controller/medical_form_controller.dart';
import 'package:admin_clinical/features/invoice/controllers/invoice_controller.dart';
import 'package:admin_clinical/features/invoice/screens/invoice_view_screen.dart';
import 'package:admin_clinical/features/medicine/screens/medicine_screen.dart';
import 'package:admin_clinical/features/overview/screens/overview_screen.dart';
import 'package:admin_clinical/features/patient/controller/patient_page_controller.dart';
import 'package:admin_clinical/features/patient/screens/list_patients_screen.dart';
import 'package:admin_clinical/features/settings/screen/setting_main_screen.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../models/user.dart';
import '../../../services/auth_service/auth_service.dart';
import '../../../services/data_service/notification_service.dart';
import '../../../services/socket_service.dart';
import '../../clinical_room/controller/clinical_room_controller.dart';
import '../../dec_doctor_examination/controller/dec_doctor_examination_controller.dart';
import '../../dec_doctor_examination/controller/doctor_examination_controller.dart';
import '../../dec_doctor_examination/screens/doctor_examination_screen.dart';
import '../../decentralization_doctor/controller/doctor_overview_controller.dart';
import '../../doctor/controller/doctor_main_controller.dart';
import '../../medicine/controller/medicine_controller.dart';
import '../../overview/controller/overview_controller.dart';
import '../../settings/controller/settings_controller.dart';

class DashboardController extends GetxController {
  var pageIndex = 0.obs;
  final Rx<Widget?> pages = Rx<Widget?>(null);
  final Rx<User?> _user = Rx<User?>(AuthService.instance.user);

  User? get user => _user.value;

  @override
  void onReady() async {
    bool response = await setUserIfNeed();
    SocketService.instance.connectSocket();
    if (AuthService.instance.user.type == "Doctor") {
      DataService.instance.getDoctorRole(AuthService.instance.user.id);
    }
    DataService.instance.fetchAllDataStream().listen(
      (event) => print(DataService.instance.checkFetchData.last),
      onDone: () async {
        if (AuthService.instance.user.type == "Admin") {
          await NotificationService.instance.fetchAllNotificationModelData();
        }
        if (response) {
          response = await _initializeAllController();
          if (response) {
            Stream.fromFuture(
              Future(
                () => pages.value = Obx(
                  () => IndexedStack(
                    index: pageIndex.value,
                    alignment: Alignment.topCenter,
                    children: listPageRole[AuthService.instance.user.type]!
                        .map((e) => e)
                        .toList(),
                  ),
                ),
              ),
            ).listen((event) {}).onDone(() {
              update(['DashboardScreen']);
            });
          }
        }
      },
    );

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
    await Get.putAsync(() => Future.value(DecDoctExaminationController()));
    await Get.putAsync(() => Future.value(MedicalFormController()));
    await Get.putAsync(() => Future.value(OverviewController()));
    await Get.putAsync(() => Future.value(InvoiceController()));
    await Get.putAsync(() => Future.value(DoctorMainController()));
    await Get.putAsync(() => Future.value(DoctorExaminationController()));
    await Get.putAsync(() => Future.value(PatientPageController()));
    await Get.putAsync(() => Future.value(ClinicalRoomController()));
    await Get.putAsync(() => Future.value(MedicineController()));
    await Get.putAsync(() => Future.value(SettingController()));
    return true;
  }

  Future<bool> fetchAllBasicData() async {
    return await DataService.instance.fetchAllData();
  }

  late final List<NavigationRailDestination> listTabButton =
      listNavigatorTab[user!.type]!
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
    ListPatientScreen(),
    DoctorMainScreen(),
    InvoiceView(),
    ClinicalRoom(),
    const MedicineScreen(),
    const SettingMainScreen(),
  ];
  static const Map<String, List<Map<String, dynamic>>> listNavigatorTab = {
    'Admin': [
      {
        'label': 'Overview',
        'icon': Icons.dashboard_outlined,
      },
      {
        'label': 'Patient',
        'icon': Icons.person_outline,
      },
      // {
      //   'label': 'Patient Wait',
      //   'icon': FontAwesomeIcons.file,
      // },
      {
        'label': 'Doctor',
        'icon': Icons.medical_information_outlined,
      },
      {
        'label': 'Payment',
        'icon': Icons.payment_outlined,
      },
      {
        'label': 'Clinical Room',
        'icon': Icons.medical_services_outlined,
      },
      {
        'label': 'Medicine',
        'icon': FontAwesome.medkit,
      },
      {
        'label': 'Setting',
        'icon': Icons.settings_outlined,
      },
    ],
    'Doctor': [
      {
        'label': 'Overview',
        'icon': Icons.dashboard_outlined,
      },
      {
        'label': 'Examination',
        'icon': FontAwesomeIcons.file,
      },
      {
        'label': 'Patient',
        'icon': Icons.person_outline,
      },
      {
        'label': 'Medicine',
        'icon': FontAwesome.medkit,
      },
      {
        'label': 'Setting',
        'icon': Icons.settings_outlined,
      },
    ]
  };
  late final Map<String, List<Widget>> listPageRole = {
    'Doctor': [
      DoctorDecOverview(),
      DoctorExaminationScreen(),
      ListPatientScreen(),
      const MedicineScreen(),
      const SettingMainScreen(),
    ],
    'Admin': [
      OverviewScreen(),
      ListPatientScreen(),
      // DoctorExaminationScreen(),
      DoctorMainScreen(),
      InvoiceView(),
      ClinicalRoom(),
      const MedicineScreen(),
      const SettingMainScreen(),
    ],
  };

  void switchTab(int index) {
    if (index >= 0 && index < listPageRole[user!.type]!.length) {
      pageIndex.value = index;
    }
  }

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete {
    SocketService.instance.disconnect();
    return super.onDelete;
  }

  @override
  void dispose() {
    print("Dashboard controller dispose");
    SocketService.instance.disconnect();
    super.dispose();
  }
}
