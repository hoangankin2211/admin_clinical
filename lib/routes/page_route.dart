import 'package:admin_clinical/features/auth/bindings/auth_binding.dart';
import 'package:admin_clinical/features/auth/screens/login_screen.dart';
import 'package:admin_clinical/features/dashboard/bindings/dashboard_binding.dart';
import 'package:admin_clinical/features/dashboard/screens/dashboard_screen.dart';
import 'package:admin_clinical/routes/name_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PagesRoute {
  static final List<GetPage> pages = [
    GetPage(
      name: PageName.loginScreen,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: PageName.dashBoard,
      page: () => DashboardScreen(),
      binding: DashBoardBinding(),
    ),
  ];
}
